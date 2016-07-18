import { Component } from '@angular/core';
import {Nav, Loading, NavController, NavParams} from 'ionic-angular';
import {SignupComponent} from 'tw-common/dist/app/directives/signup/signup.component';
import {FORM_DIRECTIVES, FormBuilder, Control, ControlGroup, Validators}  from '@angular/common';
import {TwAPIService} from 'tw-common/dist/app/services/twapi.service';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import {DashboardPage} from '../dashboard/dashboard';
import {Http, HTTP_PROVIDERS, Headers}  from '@angular/http';
import {Header} from '../header/header';
import {GAService} from 'tw-common/dist/app/services/ga.service';

/*
  Generated class for the SignupPage page.

  See http://ionicframework.com/docs/v2/components/#navigation for more info on
  Ionic pages and navigation.
*/
@Component({
  templateUrl: 'build/pages/signup/signup.html',
  pipes: [TranslatePipe],
  directives: [Header]
})
export class SignupPage extends SignupComponent{

  background:string = "account-background";
  slogan:string = "signin-slogan";

  constructor(private nav: NavController, private navParams: NavParams, translate: TranslateService, 
     twapi: TwAPIService,  builder: FormBuilder) {

  	super(translate, twapi, builder);

    GAService.screenview("SIGNUP");


	  (<Control>this.signupForm.controls['email'])
		.updateValue(this.navParams.get('email'));

	  (<Control>this.signupForm.controls['password'])
		.updateValue(this.navParams.get('password'));

  	this.userLogged.subscribe(
  		user => this.nav.setRoot(DashboardPage, {
  			user:user
  		})
  	);
  }
}
