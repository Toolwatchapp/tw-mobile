import {Nav, Loading, NavController} from 'ionic-angular';
import {Component, ElementRef, ViewChild, Input} from '@angular/core';

import {User, TwAPIService} from 'tw-common/dist/app';

import {TranslatePipe} from 'ng2-translate/ng2-translate';

@Component({
	templateUrl: 'build/components/header/header.html',
	pipes: [TranslatePipe],
	selector: "header-nav"
})
export class Header {

	@Input()
	slogan:string = "slogan";
	@Input()
	chat: boolean = false;
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
		console.log("back");
	}

	onChat(){
		TwAPIService.resetTime();
		console.log("chat");
	}
}