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
} from './../../share/src/app/';

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

		var text = this.translate.instant('below-average');

		if(watch.lastCompleteMeasure().accuracy < -10){
			text += this.translate.instant('below-average-20-10');
		}else if(watch.lastCompleteMeasure().accuracy < 10){
			text += this.translate.instant('below-average-10-25');
		}else{
			text += this.translate.instant('below-average-25');
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
		alert.present();
	}

	genBackgrounds(){

		TwAPIService.assetsUrl = "build/assets";

		for (var i = this.user.watches.length - 1; i >= 0; i--) {


			//Only computes the unknown ones
			if(DashboardPage.cachedBackgrounds[this.user.watches[i].id] === undefined){

				DashboardPage.cachedBackgrounds[this.user.watches[i].id] = {
					image: "",
					color: "transparent",
					bgColor: ""
				};

				this.twapi.getLikelyBrands(this.user.watches[i]).then(
				brands => {

						if(brands.proposals.length > 0 && brands.proposals[0].confidence > 85){
							DashboardPage.cachedBackgrounds[brands.watch.id].image = "url('build/assets/ico_watches/" + 
								brands.proposals[0].logo + "')";
						}else{
							DashboardPage.cachedBackgrounds[brands.watch.id].bgColor = "color-"+brands.watch.initials.charAt(0).toLowerCase();
							DashboardPage.cachedBackgrounds[brands.watch.id].color = "white";
						}
					}
				);
			}
		}

		this.backgrounds = DashboardPage.cachedBackgrounds;
	}

	onRefresh(refresher) {

		this.twapi.getWatches().then(
			res => {
				console.log(res);
				this.user.watches = res;
				this.genBackgrounds();
				this.resetScroll();
				refresher.complete();
			}
		)
	}

}