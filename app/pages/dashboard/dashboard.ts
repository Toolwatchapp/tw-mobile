import {Component, ElementRef, ViewChild} from '@angular/core';
import {Alert, Nav, Loading, NavController} from 'ionic-angular';
import {LoginComponent} from 'tw-common/dist/app/directives/login/login.component';
import {TwAPIService} from 'tw-common/dist/app/services/twapi.service';
import {Watch} from 'tw-common/dist/app/models/watch.model';
import {User} from 'tw-common/dist/app/models/user.model';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import {Http, HTTP_PROVIDERS, Headers}  from '@angular/http';
import {ListPage} from '../list/list';
import {Footer} from '../footer/footer';
import 'gsap';


@Component({
	templateUrl: 'build/pages/dashboard/dashboard.html',
	pipes: [TranslatePipe],
	providers: [TwAPIService, HTTP_PROVIDERS],
	directives: [Footer]
})
export class DashboardPage {


	user:User;
	

	constructor(private nav: NavController, private translate: TranslateService,
		private twapi: TwAPIService, private elementRef: ElementRef) {

		this.twapi.login("mathieu.nayrolles@gmail.com", "qwerty").then(
			res => {
				this.user = res;
				console.log(this.user);

				for (var i = 0; i < 20; i++) {
					this.user.watches.push(
						new Watch(0, "Jae")
					)
				}
			}  
		);

		
	}

	deleteWatch(watch:Watch){


		let alert = Alert.create({
			title: this.translate.instant('delete-watch-alert'),
			message: this.translate.instant('delete-watch') + watch.brand + " " + watch.name + "?",
			buttons: [
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

						this.twapi.deleteWatch(this.user, watch).then(
							res => {
								this.user = res;
								console.log("Deletion");
							}
						);
						console.log('Deletion clicked');
					}
				}
			]
		});
		this.nav.present(alert);
	}

}
