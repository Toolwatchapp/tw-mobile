import {Loading, LoadingController, NavController, NavParams} from 'ionic-angular';

import {Component} from '@angular/core';

import {TwAPIService, BlogPost, GAService} from './../../share/src/app/';

import {TranslateService} from 'ng2-translate/ng2-translate';

@Component({
	templateUrl: 'tips.html'
})
export class TipsPage {

	user:any;
	posts:BlogPost[];
	laoding:Loading;
	

	constructor(
		private nav: NavController, 
		private navParams: NavParams,
		private twapi: TwAPIService, 
		private translate: TranslateService,
		private loadingController: LoadingController
	) {

		this.user = this.navParams.get('user');
    	GAService.screenview("TIPS");

    	this.laoding = this.loadingController.create();

		this.twapi.getBlogPosts().then(
			posts => {
				this.posts = posts;
				this.laoding.dismiss();
			}
		);
	}

	ngAfterViewInit() {

		this.laoding.present();
	}
}
