import {
	NavController,
	NavParams,
	ItemSliding,
	ActionSheetController,
	AlertController
} from 'ionic-angular';

import {
	Component, 
	ElementRef, 
	EventEmitter
} from '@angular/core';

import {WatchPage} from '../watch/watch';
import {MeasurePage} from '../measure/measure';
declare var Math;
import {
	TwAPIService,
	Watch,
	WatchStatus,
	WatchAction,
	MeasureStatus,
	GAService,
	User
} from 'tw-core';

import {
	TranslateService,
} from 'ng2-translate/ng2-translate';


@Component({
	templateUrl: 'dashboard.html'
})
export class DashboardPage {
	
	user:User;
	WatchStatus = WatchStatus;
	MeasureStatus = MeasureStatus;
	WatchAction = WatchAction;
	submitAttempt:boolean = false;
	public static userChanged = new EventEmitter();
	static cachedBackgrounds = [];
	backgrounds = [];
	
	constructor(
		private nav: NavController,
		private navParams: NavParams,
		private translate: TranslateService,
		private twapi: TwAPIService,
		private elementRef: ElementRef, 
		private alertController: AlertController,
		private actionSheetController: ActionSheetController
	) {

        GAService.screenview("DASHBOARD");

		translate.setDefaultLang('en');
		translate.use('en');

		DashboardPage.userChanged.subscribe(
			user => {
				this.user = user;
				this.genBackgrounds();
				if(user.watches.length > 1){
					this.resetScroll();
				}
				console.log("user", this.user);
			}
		);

		this.user = this.navParams.get('user');
		this.genBackgrounds();
	}

	resetScroll(){
		this.elementRef.nativeElement.querySelector('#dash-list').scrollTop = 0;
	}

	updateWatch(watch:Watch, slidingItem: ItemSliding){
		console.log(watch);
		this.nav.push(WatchPage, {
			watch: watch,
			user: this.user
		});
		slidingItem.close();
	}

	measureWatch(watch: Watch){

		this.nav.push(MeasurePage, {
			watch: watch,
			user: this.user
		});
	}

	warning(watch:Watch){

		let text = this.translate.instant('accuracy-age-warning')
		+watch.lastCompleteMeasure().accuracyAge + this.translate.instant('accuracy-age-warning-contd');
			
		let alert = this.alertController.create({
	      title: this.translate.instant('accuracy-age-title'),
	      subTitle: text,
	      buttons: ['OK']
	    });
	    alert.present();
		
	}

	error(watch:Watch){

		var text = "";

		if(watch.lastCompleteMeasure().accuracy < -10){
			text += this.translate.instant('below-average') + 
			this.translate.instant('below-average-20-10');
		}else if(watch.lastCompleteMeasure().accuracy < 10){
			text += this.translate.instant('below-average') + 
			this.translate.instant('below-average-10-25');
		}else{
			text += this.translate.instant('above-average') + 
			this.translate.instant('below-average-25');
		}

		text += this.translate.instant('servicing');
			
		let alert = this.alertController.create({
		  title: this.translate.instant('below-average-title'),
	      subTitle: text,
	      buttons: ['OK']
	    });
	    alert.present();
		
	}

	newWatch(){
		this.nav.push(WatchPage, {
			user:this.user
		});
	}

	deleteMeasure(watch:Watch, slidingItem: ItemSliding){
		let alert = this.alertController.create({
			title: this.translate.instant('delete-pending-measure'),
			message: this.translate.instant('delete-pending-measure-confirm'),
			buttons: [
				{
					text: this.translate.instant('cancel'),
					role: 'cancel',
					handler: () => {
						slidingItem.close();
					}
				},
				{
					text: this.translate.instant('confirm'),
					handler: () => {

						this.submitAttempt = true;

						this.twapi.deleteMeasure(watch, watch.currentMeasure()).then(
							res => { 
								this.submitAttempt = false;
								this.user.upsertWatch(res);
								slidingItem.close();
							}
						);
					}
				}
			]
		});
		alert.present();
	}

	deleteWatch(watch:Watch, slidingItem: ItemSliding){

		let alert = this.alertController.create({
			title: this.translate.instant('delete-watch-alert'),
			message: this.translate.instant('delete-watch-confirm') + watch.brand + " " + watch.name + "?",
			buttons: [
				{
					text: this.translate.instant('cancel'),
					role: 'cancel',
					handler: () => {
						slidingItem.close();
					}
				},
				{
					text: this.translate.instant('confirm'),
					handler: () => {
						this.submitAttempt = true;
						this.twapi.deleteWatch(this.user, watch).then(
							res => {
								this.submitAttempt = false;
								this.user = res;
							}
						);
					}
				}
			]
		});
		alert.present();
	}

	genBackgrounds(){

		TwAPIService.assetsUrl = "assets/watches";

		for (var i = this.user.watches.length - 1; i >= 0; i--) {


			DashboardPage.cachedBackgrounds[this.user.watches[i].id] = {
				image: "",
				color: "transparent",
				bgColor: ""
			};

			DashboardPage.cachedBackgrounds[this.user.watches[i].id].bgColor = "color-"+this.user.watches[i].initials.charAt(0).toLowerCase();
			DashboardPage.cachedBackgrounds[this.user.watches[i].id].color = "white"; 
			
		}

		this.backgrounds = DashboardPage.cachedBackgrounds;
	}

	onRefresh(refresher) {

		this.twapi.getWatches().then(
			res => {
				this.user.watches = res;
				this.genBackgrounds();
				this.resetScroll();
				refresher.complete();
			}
		)
	}

}