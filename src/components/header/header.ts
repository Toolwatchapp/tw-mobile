import {NavController} from 'ionic-angular';
import {Component, ElementRef, Input} from '@angular/core';
import {InAppBrowser} from 'ionic-native';


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
		private nav: NavController, 
		private elementRef: ElementRef
	) { }

	onBack(){
		this.nav.pop();
	}

	onChat(){
		new InAppBrowser('https://go.crisp.im/chat/embed/?website_id=-K4rBEcM_Qbt6JrISVzu', '_system');
	}
}