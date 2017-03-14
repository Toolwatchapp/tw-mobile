import { Loading, LoadingController, NavController, AlertController } from 'ionic-angular';
import { Facebook } from 'ionic-native';
import { Storage } from '@ionic/storage';
import { Component } from '@angular/core';
import { FormBuilder } from '@angular/forms';

import {DashboardPage} from '../dashboard/dashboard';
import {SignupPage} from '../signup/signup';
import {MyApp} from '../../app/app.component';

import {
	LoginComponent,
	TwAPIService, 
	GAService,
	User
} from 'tw-core';

import {TranslateService} from 'ng2-translate/ng2-translate';

@Component({
	templateUrl: 'login.html'
})
export class LogInPage extends LoginComponent{

	laoding:Loading; 
	loadindSentence:string; 

	constructor(	
		//Own injections
		private nav: NavController, 
		private loadingController: LoadingController,
   		private storage: Storage,
		private alertController: AlertController,
		//Injections for LoginComponent	
		translate: TranslateService, 
		twapi  : TwAPIService, 
		formBuilder  : FormBuilder
	) {
		super(translate, twapi, formBuilder);

		GAService.screenview("LOGIN");

		translate.get('logging-in').subscribe(
			sentence => this.loadindSentence = sentence
		);

		this.userLogged.subscribe(
			user => this.onSuccessLogging(user)
		);

		this.loginAttempt.subscribe(
			attempt =>  this.onLoggingAttempt(attempt)
		);

		this.initOnResume();

       	this.fetchUser().then(
          user => {
          	this.userLogged.emit(user);
          },
          error => {
            console.log("No valid key set");
          }
       );
	}

	onResetPassword(){
		let prompt = this.alertController.create({
			title: this.translate.instant('password-reset'),
			message: this.translate.instant('password-reset-desc'),
			inputs: [
				{
					name: 'email',
					placeholder: this.translate.instant('email')
				},
			],
			buttons: [
				{
					text: this.translate.instant('cancel'),
					handler: () => {
						prompt.dismiss();
					}
				},
				{
					text: this.translate.instant('ok'),
					handler: (data) => {
						this.onPasswordResetSubmit(data.email);
					}
				}
			]
		});
		prompt.present();
	}

	/**
	 * Login user using facebook
	 */
	onFbSignup(){

		Facebook.browserInit(807383452677000);

		//Login call for authentifications
		Facebook.login(["public_profile", "email"]).then(
			
			//Login success
			facebookLoginResponse => {

				//Fetch user infos using the graph API
				Facebook.api("me/?fields=id,email,last_name,first_name", ["public_profile", "email"]).then(
					
					//Graph API call success
					fbUser => {

						this.onFbSubmit(
							{
							    email: fbUser.email, 
							    token: facebookLoginResponse.authResponse.accessToken,
							    lastname: fbUser.last_name, 
							    firstname: fbUser.first_name
							}
						);
					},
					//FB Graph API error
					//Can arise on connection lost or API change
					error => {
						this.errors.push("error");
					}
				)
			}, 
			//Fb Login Error
			//Can arise if the user doesn't gro through with the FB auth.
			error => {
				this.errors.push("error");
			}
		);


	}

	/**
	 * Displays SignupPage
	 */
	onSignup(){

		this.nav.push(SignupPage, {
			email:this.loginForm.controls["email"].value,
			password:this.loginForm.controls["password"].value
		});
	}

 
	/**
	 * Display loading animation when user attempt to log
	 * @param {boolean} attempt
	 */
	private onLoggingAttempt(attempt:boolean){
		if(attempt === true){
			/**
			 * We can't present a loader twice. Seams like dismiss() destroys it.
			 * @see https://github.com/Toolwatchapp/tw-mobile/issues/41
			 */
			this.laoding = this.loadingController.create({content: this.loadindSentence})
			this.laoding.present();
		}else{
			setTimeout(()=>{
				this.laoding.dismiss();
			}, 1000);
		}
	}

	/**
	 * Go to the dashboard and store API key
	 * @param {User} user
	 */
	private onSuccessLogging(user:User){
		this.laoding.dismiss();
		this.nav.setRoot(DashboardPage, {
			user:user
		});
		GAService.userName = user.name + " " + user.lastname;
		GAService.userEmail = user.email;
		MyApp.userLogged.emit();
		console.log("setting tw-api to", user.key);
		this.storage.set('tw-api', user.key);
	}

	/**
	 * Fetches and user given a stored API key
	 * @return {Promise<User>} [description]
	 */
	private fetchUser():Promise<User>{

	    return this.fetchAPIKey().then(
	       key => {
	           return this.twapi.getUser(key).then(
	            user => user,
	            err => {
	              this.loginAttempt.emit(false);
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

  /**
   * Add resume event to html body and fetches up to date
   * user from the API
   */
  private initOnResume(){
	  console.log("resime");
    document.addEventListener('resume', () => {

	if(this.nav.getActive().name != "SignupPage" || this.nav.getActive().name != "LoginPage"){

		this.translate.get('loading-dashboard').subscribe(
			sentenceLoading => {

				let laodingDashboard = this.loadingController.create({content: sentenceLoading})
				laodingDashboard.present();

				this.fetchUser().then(
					user => {
						this.onSuccessLogging(user)
						laodingDashboard.dismiss();
					},
					error => {
						this.nav.setRoot(LogInPage);
						laodingDashboard.dismiss();        
					}
				);
			}
		);
	}

      TwAPIService.resetTime();
    });
  }

  /**
   * Fetches a stored api key
   *
   * @throws on no key found
   * @return {Promise<string>} [description]
   */
  private fetchAPIKey():Promise<string>{

    return this.storage.get('tw-api').then((key) => {

      if(key !== "cordova_not_available" && key != null){
      	this.loginAttempt.emit(true);
        return key;
      }else{
        throw new Error("No valid key");
      }
    });
  }
}

