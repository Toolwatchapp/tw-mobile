import {NavController} from 'ionic-angular';
import {Component, ElementRef, Input} from '@angular/core';
import {InAppBrowser} from 'ionic-native';

import {
	LoginComponent,
	User
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

	public static email:string = null;
	public static name:string = null;

	constructor(
		private nav: NavController
	) { 
	}

	onBack(){
		this.nav.pop();
	}

	onChat(){
		let browser = new InAppBrowser('https://go.crisp.im/chat/embed/?website_id=-K4rBEcM_Qbt6JrISVzu', '_system');

		if(Header.email != null && Header.name != null){
			let script:string = 'window.CRISP_READY_TRIGGER = function() {'
			+	'$crisp.set("user:email", "'+ Header.email +'");'
			+	'$crisp.set("user:nickname", "'+   Header.name +'");'
			+'};'
			browser.executeScript({code: script});
		}
	}
}