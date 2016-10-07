import {NavController} from 'ionic-angular';
import {Component, ElementRef, Input} from '@angular/core';


@Component({
	templateUrl: 'header.html',
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
		console.log("chat");
	}
}