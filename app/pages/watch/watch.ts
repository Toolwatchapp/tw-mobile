import {Alert, AlertController, NavController, NavParams} from 'ionic-angular';

import {Component} from '@angular/core';
import {FormBuilder}  from '@angular/common';

import {
	TwAPIService, 
	Watch,
	User,
	WatchComponent,
	GAService
} from 'tw-common/dist/app';

import {DashboardPage} from '../dashboard/dashboard';
import {Header}  from '../header/header';

import {TranslateService, TranslatePipe} from 'ng2-translate/ng2-translate';

@Component({
	templateUrl: 'build/pages/watch/watch.html',
	pipes: [TranslatePipe],
	directives: [Header]
})
export class WatchPage extends WatchComponent {
	
	background:string = "addWatch-background";
	slogan:string ="add-new-watch";

	constructor(
		private nav: NavController, 
		private navParams: NavParams, 
		private alertController: AlertController,
		translate: TranslateService,
		twapi: TwAPIService, 
		builder: FormBuilder
	) {

		super(translate, twapi, builder);

    	GAService.screenview("WATCH");

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
		let alert = this.alertController.create({
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
		alert.present();
	}
}