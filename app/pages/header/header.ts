import 'gsap';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import {Component, ElementRef, ViewChild, Input} from '@angular/core';
import {Nav, Loading, NavController} from 'ionic-angular';
import {WatchPage} from '../watch/watch';
import {User} from 'tw-common/dist/app/models/user.model';



declare var TimelineMax: any;
declare var Quint: any;
declare var Quad: any;
declare var Elastic: any;

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

	constructor(private nav: NavController, private elementRef: ElementRef) {

	}

	onBack(){
		this.nav.pop();
		console.log("back");
	}

	onChat(){
		console.log("chat");
	}
}