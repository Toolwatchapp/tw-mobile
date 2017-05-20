import { Component, ViewChild, EventEmitter } from '@angular/core';
import { Platform, Nav, AlertController, MenuController } from 'ionic-angular';
import { Storage } from '@ionic/storage';
import { AppVersion } from '@ionic-native/app-version';
import { Keyboard } from '@ionic-native/keyboard';
import { StatusBar } from '@ionic-native/status-bar';
import { InAppBrowser } from '@ionic-native/in-app-browser';
import { AnalyticsService, TwAPIService } from 'tw-core';
import { TranslateService } from '@ngx-translate/core';

@Component({
  template: `
  <ion-menu [content]="content">
  <ion-header>
    <ion-toolbar>
      <ion-title>Menu</ion-title>
    </ion-toolbar>
  </ion-header>
  <ion-content>
    <ion-list>
      <button ion-item menuToggle (click)="contact()"  icon-left>
         <ion-icon name="ios-chatbubbles"></ion-icon>
        {{ 'contact' | translate }}
      </button>
      <button ion-item menuToggle (click)="beer()" icon-left>
          <ion-icon name="ios-pint"></ion-icon>
        {{ 'buy-us-beer' | translate }}
      </button>
      <button ion-item menuToggle (click)="facebook()" icon-left>
        <ion-icon name="logo-facebook"></ion-icon>
        Facebook
      </button>
      <button ion-item menuToggle (click)="instagram()" icon-left>
        <ion-icon name="logo-instagram"></ion-icon>
        Instagram
      </button>
      <button ion-item menuToggle (click)="pinterest()" icon-left>
        <ion-icon name="logo-pinterest"></ion-icon>
        Pinterest
      </button>
      <button ion-item menuToggle (click)="twitter()" icon-left>
        <ion-icon name="logo-twitter"></ion-icon>
        Twitter
      </button>
      <button ion-item menuToggle (click)="logout()" icon-left>
        <ion-icon name="md-exit"></ion-icon>
        {{ 'logout' | translate }}
      </button>
      <button ion-item (click)="deleteAccount()" icon-left>
        <ion-icon name="ios-trash"></ion-icon>
        {{ 'delete-account' | translate }}
      </button>
    </ion-list>
    <p id="version">v.{{version}}</p>
  </ion-content>
</ion-menu>
<ion-nav [root]="rootPage" #content swipeBackEnabled="false"></ion-nav>`
})
export class MyApp {
  @ViewChild(Nav) nav: Nav;
  rootPage: any = 'LogInPage';
  version: string;
  public static userLogged = new EventEmitter();

  constructor(
    private platform: Platform,
    private twapi: TwAPIService,
    private alertController: AlertController,
    private menuController: MenuController,
    private analytics: AnalyticsService,
    private storage: Storage,
    private translate: TranslateService,
    private keyboard: Keyboard,
    private appVersion: AppVersion,
    private statusBar: StatusBar,
    private iab: InAppBrowser
  ) {

    platform.ready().then(() => {
      // Okay, so the platform is ready and our plugins are available.
      // Here you can do any higher level native things you might need.
      statusBar.styleDefault();

      //keyboard.disableScroll(true);
      this.menuController.enable(false);
     

      MyApp.userLogged.subscribe(
        () => { this.menuController.enable(true); }
      );

      appVersion.getVersionNumber().then(
        (version) => {
          analytics.appVersion = version;
          this.version = version;
        }
      ).catch(
        (err) => {
          analytics.appVersion = "0.0.0";
          this.version = "0.0.0";
        }
        );

      if (platform.is('ios')) {
        analytics.appName = "ios";
      } else {
        analytics.appName = "android";
      }
    });
  }

  intagram() {
    window.open("https://instagram.com/toolwatchapp/");
  }

  pinterest() {
    window.open("https://www.pinterest.com/toolwatch/");
  }

  twitter() {
    window.open("https://twitter.com/ToolwatchApp");
  }

  facebook() {
    window.open("https://www.facebook.com/Toolwatch/");
  }

  contact() {
    let browser = this.iab.create('https://go.crisp.im/chat/embed/?website_id=-K4rBEcM_Qbt6JrISVzu', '_blank');

		/**
		 * Don't do inject if user isn't logged yet
		 */
    if (this.analytics.userEmail != null && this.analytics.userName != null) {


      let script: string = ''
        + '$crisp.set("user:email", "' + this.analytics.userEmail + '");'
        + '$crisp.set("user:nickname", "' + this.analytics.userName + '");'
        + ''
      browser.executeScript({ code: script });
    }
    this.menuController.close();

  }

  beer() {
    this.iab.create('https://ko-fi.com/A872I1N', '_blank');
    this.menuController.close();
  }

  logout() {
    this.menuController.enable(false);
    this.storage.remove("tw-api");
    this.nav.setRoot('LogInPage');
  }

  deleteAccount() {
    let alert = this.alertController.create({
      title: this.translate.instant('Delete your account'),
      message: this.translate.instant('delete-account-warning'),
      buttons:
      [
        {
          text: this.translate.instant('cancel'),
          role: 'cancel',
          handler: () => {
            console.log('Cancel clicked');
          }
        },
        {
          text: this.translate.instant('confirm'),
          handler: () => {

            this.twapi.deleteAccount().then(
              () => {
                alert.dismiss();
                this.logout();
              }
            );
          }
        }
      ]
    });
    alert.present();
  }
}

