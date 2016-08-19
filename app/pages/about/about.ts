import {
    Nav, 
    Loading, 
    NavController, 
    NavParams
} from 'ionic-angular';

import {
    Component, 
    forwardRef
} from '@angular/core';

import { HTTP_PROVIDERS }  from '@angular/http';

import {Header}  from '../header/header';
import {Footer} from '../footer/footer';

import {
    TwAPIService, 
    BlogPost, 
    GAService
} from 'tw-common/dist/app';

import {
    TranslatePipe, TranslateService
} from 'ng2-translate/ng2-translate';


@Component({
	templateUrl: 'build/pages/about/about.html',
	pipes: [TranslatePipe],
	directives: [forwardRef(() => Footer), Header]
})
export class AboutPage {

	user:any;

	constructor(
        private nav: NavController, 
        private navParams: NavParams,
		private twapi: TwAPIService, 
        private translate: TranslateService
    ) {

        GAService.screenview("ABOUT");
		this.user = this.navParams.get('user');
	}
}