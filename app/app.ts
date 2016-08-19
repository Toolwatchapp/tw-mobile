import {Component, ViewChild, provide} from '@angular/core';
import {ionicBootstrap, Platform, Nav} from 'ionic-angular';
import {StatusBar} from 'ionic-native';
import {LogInPage} from './pages/login/login';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import {HTTP_PROVIDERS, Http} from '@angular/http';
import {DashboardPage} from './pages/dashboard/dashboard';
import {TwAPIService} from 'tw-common/dist/app/services/twapi.service';
import {GAService} from 'tw-common/dist/app/services/ga.service';
import { NativeStorage } from 'ionic-native';
import {User} from 'tw-common/dist/app/models/user.model';
import { disableDeprecatedForms, provideForms } from '@angular/forms';

@Component({
  templateUrl: 'build/app.html'
})
class MyApp {
  @ViewChild(Nav) nav: Nav;
  rootPage: any;

  constructor(
    private platform: Platform, private twapi:TwAPIService) {

    this.initOnResume();
    this.initializeApp();
    this.initializeGA();
  }

  private initOnResume(){
    document.addEventListener('resume', () => {

      this.fetchUser().then(
        user => {
          DashboardPage.userChanged.emit(user)
        }
      );
      
      TwAPIService.resetTime();
    });
  }

  private fetchUser():Promise<User>{

    return this.fetchAPIKey().then(
       key => {
         if(key !== "cordova_not_available"){
           return this.twapi.getUser(key).then(
            user => user,
            err => {console.log("removing", key); NativeStorage.remove('tw-api')}
          )
         }else{
           console.log("removing", key); 
           NativeStorage.remove('tw-api')
           return undefined;
         } 
       }
    );
  }

  private fetchAPIKey():Promise<string>{
    return NativeStorage.getItem('tw-api')
      .then(
        data => data.key,
        error => error
      );
  }

  private initializeGA(){
    GAService.appVersion = "0.7.0";
    if(this.platform.is('ios')){
     GAService.appName = "ios";
    }else{
     GAService.appName = "android";
    }
  }

  private initializeApp() {
    this.platform.ready().then(() => {

      this.fetchUser()
      .then(
        user => {
          if(user !== undefined){

            console.error(user);
            this.rootPage = DashboardPage;
            setTimeout(()=> DashboardPage.userChanged.emit(user), 1000);
          }else{
            this.rootPage = LogInPage;
          }
        }
      ).catch((error)=>{this.rootPage = LogInPage; console.log(error)})

      // Okay, so the platform is ready and our plugins are available.
      // Here you can do any higher level native things you might need.
      StatusBar.styleDefault();
    });
  }

}



ionicBootstrap(MyApp, [
  disableDeprecatedForms(), // disable deprecated forms
  provideForms(), // enable new forms module
  TwAPIService,
  HTTP_PROVIDERS,
  { 
    provide: TranslateLoader,
    useFactory: (http: Http) => new TranslateStaticLoader(http, 'build/assets/i18n', '.json'),
    deps: [Http]
  },
  // use TranslateService here, and not TRANSLATE_PROVIDERS (which will define a default TranslateStaticLoader)
  TranslateService]);
