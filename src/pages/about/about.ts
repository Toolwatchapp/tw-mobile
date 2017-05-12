import {
    NavParams
} from 'ionic-angular';
import { InAppBrowser } from '@ionic-native/in-app-browser';

import {
    Component
} from '@angular/core';


import {
    AnalyticsService
} from 'tw-core';

import { TranslateService } from '@ngx-translate/core';


@Component({
    templateUrl: 'about.html'
})
export class AboutPage {

    user: any;

    constructor(
        private navParams: NavParams,
        private translate: TranslateService,
        private analytics: AnalyticsService,
        private iab: InAppBrowser
    ) {

        this.analytics.screenview("ABOUT");
        this.user = this.navParams.get('user');
    }

    buyUsBeer() {
        this.iab.create('https://ko-fi.com/A872I1N', '_blank');
    }
}