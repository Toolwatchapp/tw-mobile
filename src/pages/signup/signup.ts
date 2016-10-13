import {NavController, NavParams, Loading, LoadingController} from 'ionic-angular';

import { Component } from '@angular/core';

import {DashboardPage} from '../dashboard/dashboard';
import { FormBuilder } from '@angular/forms';
import {
  SignupComponent,
  TwAPIService,
  GAService
} from './../../share/src/app/';

import {TranslateService} from 'ng2-translate/ng2-translate';

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
    //injection for SignupComponent
    translate: TranslateService, 
    twapi: TwAPIService,  
    builder: FormBuilder
  ) {

  	super(translate, twapi, builder);

    GAService.screenview("SIGNUP");

  	this.userLogged.subscribe(
  		user => this.nav.setRoot(DashboardPage, {
  			user:user
  		})
  	);

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