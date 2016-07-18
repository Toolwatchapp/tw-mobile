import {Component, ViewChild, provide} from '@angular/core';
import {ionicBootstrap, Platform, Nav} from 'ionic-angular';
import {StatusBar} from 'ionic-native';
import {LogInPage} from './pages/login/login';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import {HTTP_PROVIDERS, Http} from '@angular/http';
import {DashboardPage} from './pages/dashboard/dashboard';
import {TwAPIService} from 'tw-common/dist/app/services/twapi.service';
import {GAService} from 'tw-common/dist/app/services/ga.service';

@Component({
  templateUrl: 'build/app.html'
})
class MyApp {
  @ViewChild(Nav) nav: Nav;

  // make HelloIonicPage the root (or first) page
  rootPage: any = LogInPage;
  pages: Array<{title: string, component: any}>;

  constructor(
    private platform: Platform
  ) {
    document.addEventListener('resume', () => {
      TwAPIService.resetTime();
    });
    GAService.appVersion = "0.0.5";
    if(platform.is('ios')){
     GAService.appName = "ios";
    }else{
     GAService.appName = "android";
    }
  }

  initializeApp() {
    this.platform.ready().then(() => {
      // Okay, so the platform is ready and our plugins are available.
      // Here you can do any higher level native things you might need.
      StatusBar.styleDefault();
    });
  }

}

ionicBootstrap(MyApp, [
  TwAPIService,
  HTTP_PROVIDERS,
  provide(TranslateLoader, {
    useFactory: (http: Http) => new TranslateStaticLoader(http, 'build/assets/i18n', '.json'),
    deps: [Http]
  }),
  // use TranslateService here, and not TRANSLATE_PROVIDERS (which will define a default TranslateStaticLoader)
  TranslateService]);
