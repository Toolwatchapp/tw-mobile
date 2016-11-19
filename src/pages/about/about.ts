import {
    NavParams
} from 'ionic-angular';

import {
    Component
} from '@angular/core';


import {
    GAService
} from '../../core';

import {
    TranslateService
} from 'ng2-translate/ng2-translate';


@Component({
	templateUrl: 'about.html'
})
export class AboutPage {

	user:any;

	constructor(
        private navParams: NavParams,
        private translate: TranslateService
    ) {

        GAService.screenview("ABOUT");
		this.user = this.navParams.get('user');
	}
}