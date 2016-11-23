import {NavController} from 'ionic-angular';
import {Component, ElementRef, Input} from '@angular/core';
import {InAppBrowser} from 'ionic-native';

import {
	GAService
} from '../../core';

@Component({
	templateUrl: 'header.html',
	selector: "header-nav"
})
export class Header {

	@Input()
	slogan:string = "slogan";
	@Input()
	chat: boolean = true;
	@Input()
	back:boolean = false;
	@Input()
	topBg:string = "handBg";

	constructor(
		private nav: NavController
	) { 
	}

	onBack(){
		this.nav.pop();
	}

	onChat(){
		let browser = new InAppBrowser('https://go.crisp.im/chat/embed/?website_id=-K4rBEcM_Qbt6JrISVzu', '_system');

		if(GAService.userEmail != null && GAService.userName != null){


			let script:string = ''
			+	'$crisp.set("user:email", "'+ GAService.userEmail +'");'
			+	'$crisp.set("user:nickname", "'+   GAService.userName +'");'
			+''
			console.log(script);
			browser.executeScript({code: script});
		}
	}
}