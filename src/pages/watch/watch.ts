import { AlertController, NavController, NavParams} from 'ionic-angular';

import {Component} from '@angular/core';
import { FormBuilder } from '@angular/forms';

import {
	TwAPIService, 
	Watch,
	WatchComponent,
	GAService
} from './../../share/src/app/';

import {DashboardPage} from '../dashboard/dashboard';

import {TranslateService} from 'ng2-translate/ng2-translate';

@Component({
	templateUrl: 'watch.html'
})
export class WatchPage extends WatchComponent {
	
	background:string = "addWatch-background";
	slogan:string ="add-new-watch";
	errors = [
		{flag:this.error, label:"error"}
	];

	constructor(
		//Own injections
		private nav: NavController, 
		private navParams: NavParams, 
		private alertController: AlertController,
		//Injections for WatchComponent
		translate: TranslateService,
		twapi: TwAPIService, 
		builder: FormBuilder
	) {

		super(translate, twapi, builder);

    	GAService.screenview("WATCH");

		TwAPIService.assetsUrl = "assets/watches";

		this.user = this.navParams.get('user');

		this.watchSaved.subscribe(
			user => {
				DashboardPage.userChanged.emit(user);
				this.nav.pop();
			}
		);

		//The view is used for edit and create watches both.
		//Here, we check if we received a watch and adapt the 
		//textual context of the view.
		let receivedWatch:Watch = this.navParams.get('watch');
		console.log(this.navParams.get('watch'));
		if (receivedWatch !== undefined){

			this.watchModel = receivedWatch.clone();
			this.slogan = "edit-watch";
			this.initForm();
		}	
	}

	/**
	 * Preempt delete action to present a confirmation popup
	 */
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