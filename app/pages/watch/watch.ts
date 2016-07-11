import {Component, ElementRef, ViewChild} from '@angular/core';
import {Alert, Nav, Loading, NavController, NavParams} from 'ionic-angular';
import {TwAPIService} from 'tw-common/dist/app/services/twapi.service';
import {Watch} from 'tw-common/dist/app/models/watch.model';
import {User} from 'tw-common/dist/app/models/user.model';
import {WatchComponent} from 'tw-common/dist/app/directives/watch/watch.component';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import {Http, HTTP_PROVIDERS, Headers}  from '@angular/http';
import {DashboardPage} from '../dashboard/dashboard';
import {FORM_DIRECTIVES, FormBuilder, Control, ControlGroup, Validators}  from '@angular/common';
import {Header}  from '../header/header';
import 'gsap';

@Component({
	templateUrl: 'build/pages/watch/watch.html',
	pipes: [TranslatePipe],
	directives: [Header]
})
export class WatchPage extends WatchComponent {
	
	background:string = "addWatch-background";
	slogan:string ="add-new-watch";

	constructor(private nav: NavController, private navParams: NavParams, 
		translate: TranslateService,
		twapi: TwAPIService, builder: FormBuilder) {

		super(translate, twapi, builder);

		TwAPIService.assetsUrl = "build/assets";

		this.user = this.navParams.get('user');

		let receivedWatch:Watch = this.navParams.get('watch');
		if (receivedWatch !== undefined){
			this.watchModel = receivedWatch;
			this.slogan = "edit-watch";
		}


		this.watchSaved.subscribe(
			user => {
				DashboardPage.userChanged.emit(user);
				this.nav.pop();
			}
		);
	}

	onDelete(){
		let alert = Alert.create({
		title: this.translate.instant('delete-watch-alert'),
		message: this.translate.instant('delete-watch-confirm') + this.watchModel.brand + " " +  this.watchModel.name + "?",
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

						super.onDelete();
					}
				}
			]
		});
		this.nav.present(alert);
	}
}