import {NavController, NavParams} from 'ionic-angular';

import { Component } from '@angular/core';

import {DashboardPage} from '../dashboard/dashboard';
import {Header} from '../header/header';
import { FormBuilder, FormControl } from '@angular/forms';
import {
  SignupComponent,
  TwAPIService,
  GAService
} from 'tw-common/dist/app';

import {TranslateService, TranslatePipe} from 'ng2-translate/ng2-translate';

@Component({
  templateUrl: 'build/pages/signup/signup.html',
  pipes: [TranslatePipe],
  directives: [Header]
})
export class SignupPage extends SignupComponent{

  background:string = "account-background";
  slogan:string = "signin-slogan";

  constructor(
    //Own injection
    private nav: NavController, 
    private navParams: NavParams, 
    //injection for SignupComponent
    translate: TranslateService, 
    twapi: TwAPIService,  
    builder: FormBuilder
  ) {

  	super(translate, twapi, builder);

    GAService.screenview("SIGNUP");

	  (<FormControl>this.signupForm.controls['email'])
		.updateValue(this.navParams.get('email'));

	  (<FormControl>this.signupForm.controls['password'])
		.updateValue(this.navParams.get('password'));

  	this.userLogged.subscribe(
  		user => this.nav.setRoot(DashboardPage, {
  			user:user
  		})
  	);
  }
}