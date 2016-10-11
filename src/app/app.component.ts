import { Component } from '@angular/core';
import { Platform } from 'ionic-angular';
import { StatusBar, NativeStorage } from 'ionic-native';

import { LogInPage } from '../pages/login/login';
import { DashboardPage } from '../pages/dashboard/dashboard';

import {
	TwAPIService
} from './../share/src/app/';

@Component({
  template: `<ion-nav [root]="rootPage"></ion-nav>`
})
export class MyApp {
  rootPage = LogInPage;

  constructor(platform: Platform) {
    platform.ready().then(() => {

      this.initOnResume();

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
}
