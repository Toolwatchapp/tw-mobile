import {NavController, NavParams, Loading, LoadingController} from 'ionic-angular';
import { Storage } from '@ionic/storage';
import { Component } from '@angular/core';

import {DashboardPage} from '../dashboard/dashboard';
import { FormBuilder } from '@angular/forms';
import {
  SignupComponent,
  TwAPIService,
  AnalyticsService
} from 'tw-core';

import { TranslateService } from '@ngx-translate/core';

@Component({
  templateUrl: 'signup.html'
})
export class SignupPage extends SignupComponent{

  background:string = "account-background";
  slogan:string = "signin-slogan";
  laoding:Loading; 


  constructor(
    //Own injection
    private nav: NavController, 
    private navParams: NavParams, 
    private loadingController: LoadingController,
    private storage: Storage,
    //injection for SignupComponent
    translate: TranslateService, 
    twapi: TwAPIService,  
    builder: FormBuilder,
    analytics: AnalyticsService
  ) {

  	super(translate, twapi, builder, analytics);

    this.analytics.screenview("SIGNUP");

  	this.userLogged.subscribe(user => {
          this.nav.setRoot(DashboardPage, {
            user:user
          });
		      console.log("setting tw-api to", user.key);
		      this.storage.set('tw-api', user.key);
    });
      

    this.signupAttempt.subscribe(
      attempt => {
        if(attempt === true){

          translate.get('signin-loading').subscribe(
            sentence => {
              this.laoding = this.loadingController.create({content: sentence})
              this.laoding.present();
            }
          );
          
        }else{
          setTimeout(()=>{
            this.laoding.dismiss();
          }, 1000);
        }
      }
    )
  }
}