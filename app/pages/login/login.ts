import {Component, ViewChild} from '@angular/core';
import {Nav, Loading, NavController} from 'ionic-angular';
import {LoginComponent} from 'tw-common/dist/app/directives/login/login.component';
import {FORM_DIRECTIVES, FormBuilder, Control, ControlGroup, Validators}  from '@angular/common';
import {TwAPIService} from 'tw-common/dist/app/services/twapi.service';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import {Http, HTTP_PROVIDERS, Headers}  from '@angular/http';
import {DashboardPage} from '../dashboard/dashboard';
import {Header} from '../header/header';
import {SignupPage} from '../signup/signup';
import {Facebook} from 'ionic-native';
import {GAService} from 'tw-common/dist/app/services/ga.service';

@Component({
	templateUrl: 'build/pages/login/login.html',
	pipes: [TranslatePipe],
	directives: [Header]
})
export class LogInPage extends LoginComponent {

	laoding:Loading;

	constructor(private nav: NavController, translate: TranslateService,
		twapi: TwAPIService, builder: FormBuilder) {
		super(translate, twapi, builder);

		GAService.screenview("LOGIN");
		
		translate.get('logging-in').subscribe(
			sentence => this.laoding = Loading.create({
					content: sentence
				}
			)
		);

		this.userLogged.subscribe(
			user => {
				this.laoding.dismiss();
				this.nav.setRoot(DashboardPage, {
					user:user
				})
			}
		);

		this.loginAttempt.subscribe(
			attempt => {
				if(attempt === true){
					this.nav.present(this.laoding);
				}else{
					this.laoding.dismiss();
				}
			}
		);

	}

	onSignup(){

		this.nav.push(SignupPage, {
			email:this.email.value,
			password:this.password.value
		});
	}

}
