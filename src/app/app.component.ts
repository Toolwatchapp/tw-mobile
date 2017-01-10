import { Component, ViewChild } from '@angular/core';
import { Platform, Nav } from 'ionic-angular';
import { StatusBar, AppVersion, Keyboard  } from 'ionic-native';

import { LogInPage } from '../pages/login/login';
import { GAService, TwAPIService } from 'tw-core';

@Component({
  template: `<ion-nav [root]="rootPage" #content swipeBackEnabled="false"></ion-nav>`
})
export class MyApp{
  @ViewChild(Nav) nav: Nav;
  rootPage: any = LogInPage;

  constructor(
    platform: Platform
  ) {

    platform.ready().then(() => {
      // Okay, so the platform is ready and our plugins are available.
      // Here you can do any higher level native things you might need.
      StatusBar.styleDefault();

      TwAPIService.baseUrl = "https://toolwatch.io/api/";

      Keyboard.disableScroll(true);

      AppVersion.getVersionNumber().then(
        (version)=> GAService.appVersion = version
      ).catch(
        (err)=> {GAService.appVersion = "0.0.0"}
      );

      if(platform.is('ios')){
        GAService.appName = "ios";
      }else{
        GAService.appName = "android";
      }
    });
  }
}

