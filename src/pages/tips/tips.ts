import { Loading, LoadingController, NavController, NavParams } from 'ionic-angular';
import { Component } from '@angular/core';
import { TwAPIService, BlogPost, AnalyticsService } from 'tw-core';
import { TranslateService } from '@ngx-translate/core';

@Component({
    templateUrl: 'tips.html'
})
export class TipsPage {

    user: any;
    posts: BlogPost[];
    laoding: Loading;
    
    constructor(
        private nav: NavController, 
        private navParams: NavParams,
        private twapi: TwAPIService, 
        private translate: TranslateService,
        private loadingController: LoadingController,
        private analytics: AnalyticsService
    ) {

        this.user = this.navParams.get('user');
        this.analytics.screenview("TIPS");

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
