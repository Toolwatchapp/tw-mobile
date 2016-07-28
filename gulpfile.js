var gulp = require('gulp'),
    gulpWatch = require('gulp-watch'),
    del = require('del'),
    runSequence = require('run-sequence'),
    argv = process.argv,
    bump = require('gulp-bump'),
    args = require('yargs').argv,
    replace = require('gulp-replace'),
    fs = require('fs'),
    semver = require('semver');



var getPackageJson = function () {
  return JSON.parse(fs.readFileSync('./package.json', 'utf8'));
};

gulp.task('bump', function () {
    /// <summary>
    /// It bumps revisions
    /// Usage:
    /// 1. gulp bump : bumps the package.json and bower.json to the next minor revision.
    ///   i.e. from 0.1.1 to 0.1.2
    /// 2. gulp bump --version 1.1.1 : bumps/sets the package.json and bower.json to the 
    ///    specified revision.
    /// 3. gulp bump --type major       : bumps 1.0.0 
    ///    gulp bump --type minor       : bumps 0.1.0
    ///    gulp bump --type patch       : bumps 0.0.2
    /// </summary>

    var type = args.type;
    var version = args.version;

    if(type === undefined){
      type = "patch";
    }

    var oldVer = getPackageJson().version;
    var newVer = semver.inc(oldVer, type).replace('-', '.');

    gulp.src(['app/pages/header/header.html'])
      .pipe(replace(oldVer, newVer))
      .pipe(gulp.dest('app/pages/header'));

    gulp.src(['app/pages/app.ts'])
      .pipe(replace(oldVer, newVer))
      .pipe(gulp.dest('app/pages'));

    gulp.src(['config.xml'])
      .pipe(replace(
        'oolwatch" version="'+oldVer+'"', 
        'oolwatch" version="'+newVer+'"'))
      .pipe(gulp.dest('.'));

    var options = {};
    options.type = type;
    options.version = newVer;

    gulp.src(['package.json'])
        .pipe(bump(options))
        .pipe(gulp.dest('.'));

});

/**
 * Ionic hooks
 * Add ':before' or ':after' to any Ionic project command name to run the specified
 * tasks before or after the command.
 */
gulp.task('serve:before', ['watch']);
gulp.task('emulate:before', ['build']);
gulp.task('deploy:before', ['build']);
gulp.task('build:before', ['build']);

// we want to 'watch' when livereloading
var shouldWatch = argv.indexOf('-l') > -1 || argv.indexOf('--livereload') > -1;
gulp.task('run:before', [shouldWatch ? 'watch' : 'build']);

/**
 * Ionic Gulp tasks, for more information on each see
 * https://github.com/driftyco/ionic-gulp-tasks
 *
 * Using these will allow you to stay up to date if the default Ionic 2 build
 * changes, but you are of course welcome (and encouraged) to customize your
 * build however you see fit.
 */
var buildBrowserify = require('ionic-gulp-browserify-typescript');
var buildSass = require('ionic-gulp-sass-build');
var copyHTML = require('ionic-gulp-html-copy');
var copyFonts = require('ionic-gulp-fonts-copy');
var copyScripts = require('ionic-gulp-scripts-copy');

var isRelease = argv.indexOf('--release') > -1;

gulp.task('watch', ['clean'], function(done){
  runSequence(
    ['sass', 'html', 'fonts', 'scripts', 'assets', 'externalFonts', 'bump'],
    function(){
      gulpWatch('app/**/*.scss', function(){ gulp.start('sass'); });
      gulpWatch('app/**/*.html', function(){ gulp.start('html'); });
      buildBrowserify({ watch: true }).on('end', done);
    }
  );
});

gulp.task('build', ['clean'], function(done){
  runSequence(
    ['sass', 'html', 'fonts', 'scripts', 'assets', 'externalFonts', 'bump'],
    function(){
      buildBrowserify({
        minify: isRelease,
        browserifyOptions: {
          debug: !isRelease
        },
        uglifyOptions: {
          mangle: false
        }
      }).on('end', done);
    }
  );
});
    

gulp.task('sass', buildSass);
gulp.task('html', copyHTML);
gulp.task('fonts', copyFonts);
gulp.task('scripts', copyScripts);
gulp.task('assets', function(){
  return copyScripts({src:'node_modules/tw-common/dist/app/assets/**/*', dest:'www/build/assets'});
});
gulp.task('externalFonts', function(){
  return copyScripts({src:'node_modules/tw-common/dist/app/assets/fonts/**/*', dest:'www/build/fonts'});
});
gulp.task('clean', function(){
  return del('www/build');
});
