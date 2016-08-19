import {
	Alert,
	Loading,
	NavController,
	NavParams,
	ActionSheet,
	ItemSliding,
	ActionSheetController,
	AlertController
} from 'ionic-angular';

import {
	Component, 
	ElementRef, 
	EventEmitter
} from '@angular/core';'@angular/http';

import {Footer} from '../footer/footer';
import {WatchPage} from '../watch/watch';
import {Header} from '../header/header';
import {MeasurePage} from '../measure/measure';

import {
	LoginComponent,
	TwAPIService,
	Watch,
	WatchStatus,
	WatchAction,
	MeasureStatus,
	GAService,
	ArethmeticSign,
	User
} from 'tw-common/dist/app';

import {
	TranslateService,
	TranslatePipe
} from 'ng2-translate/ng2-translate';


@Component({
	templateUrl: 'build/pages/dashboard/dashboard.html',
	pipes: [TranslatePipe, ArethmeticSign],
	directives: [Footer, Header]
})
export class DashboardPage {
	
	user:User;
	WatchStatus = WatchStatus;
	MeasureStatus = MeasureStatus;
	WatchAction = WatchAction;
	public static userChanged = new EventEmitter();
	
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
				this.resetScroll();
				console.log("user", this.user);
			}
		);

		this.user = this.navParams.get('user');
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

	share(){

        GAService.event("CTA", "SHARE", "DASHBOARD");

		let actionSheet = this.actionSheetController.create({
			title: 'Modify your album',
			buttons: [
				{
					text: 'Destructive',
					role: 'destructive',
					handler: () => {
						console.log('Destructive clicked');
					}
				}, {
					text: 'Archive',
					handler: () => {
						console.log('Archive clicked');
					}
				}, {
					text: 'Cancel',
					role: 'cancel',
					handler: () => {
						console.log('Cancel clicked');
					}
				}
			]
		});
		actionSheet.present();
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

	onRefresh(refresher) {

		this.twapi.getWatches().then(
			res => {
				console.log(res);
				this.user.watches = res;
				this.resetScroll();
				refresher.complete();
			}
		)
	}

}
