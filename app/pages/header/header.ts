import 'gsap';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import {Component, ElementRef, ViewChild, Input} from '@angular/core';
import {Nav, Loading, NavController} from 'ionic-angular';
import {WatchPage} from '../watch/watch';
import {User} from 'tw-common/dist/app/models/user.model';


@Component({
	templateUrl: 'build/pages/header/header.html',
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

	constructor(private nav: NavController, private elementRef: ElementRef) {

		console.log(this.topBg);
		console.log(this.slogan);
	}

	onBack(){
		this.nav.pop();
		console.log("back");
	}

	onChat(){
		console.log("chat");
	}
}