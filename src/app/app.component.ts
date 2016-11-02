import { Component, ViewChild } from '@angular/core';
import { Platform, Nav } from 'ionic-angular';
import { StatusBar } from 'ionic-native';
import { Storage } from '@ionic/storage';

import { LogInPage } from '../pages/login/login';
import { DashboardPage } from '../pages/dashboard/dashboard';

import { 
	TwAPIService,
  User
} from './../share/src/app/';

@Component({
  template: `<ion-nav [root]="rootPage" #content swipeBackEnabled="false"></ion-nav>`
})
export class MyApp {
  @ViewChild(Nav) nav: Nav;
  rootPage: any = LogInPage;

  constructor(
    private platform: Platform,
    private twapi: TwAPIService,
    private storage: Storage
  ) {

    platform.ready().then(() => {

      this.initOnResume();

      this.fetchUser()
      .then(
        user => {

          this.nav.setRoot(DashboardPage, {
            user:user
          });
        },
        error => {
          console.log("No valid key set");
        }
      );


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
           return this.twapi.getUser(key).then(
            user => user,
            err => {
              console.log("removing", key); 
              this.storage.remove('tw-api')
              throw err;
            }
          )
       },
       err => {
          throw err;
       }
    )
  }

  private fetchAPIKey():Promise<string>{

    return this.storage.get('tw-api').then((key) => {

      if(key !== "cordova_not_available" && key != null){
        return key;
      }else{
        throw new Error("awd");
      }
    });
  }
}
