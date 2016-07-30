import 'gsap';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import {Component, ElementRef, ViewChild, Input} from '@angular/core';
import {Alert, Nav, Loading, NavParams, NavController} from 'ionic-angular';
import {WatchPage} from '../watch/watch';
import {TipsPage} from '../tips/tips';
import {TimePage} from '../time/time';
import {User} from 'tw-common/dist/app/models/user.model';
import {Watch, WatchAction} from 'tw-common/dist/app/models/watch.model';
import {Header}  from '../header/header';
import {MeasurePage}  from '../measure/measure';
import {AboutPage}  from '../about/about';
import {DashboardPage}  from '../dashboard/dashboard';
import { HTTP_PROVIDERS }  from '@angular/http';
import {SocialSharing} from 'ionic-native';
declare var window;


import { Wove } from 'aspect.js/dist/lib/aspect';
import {TwAPIService} from 'tw-common/dist/app/services/twapi.service';

declare var TimelineMax: any;
declare var Quint: any;
declare var Quad: any;
declare var Elastic: any;

@Wove()
@Component({
	templateUrl: 'build/pages/footer/footer.html',
	pipes: [TranslatePipe],
	selector: "footer-nav"
})
export class Footer {

	@Input()
	user:User;

	tl = new TimelineMax();
	qt = new Quint();
	menuItemNum: number = 3;
	angle: number = 120;
	distance: number = 90;
	startingAngle: number = 180 + (-this.angle / 2);
	slice: number = this.angle / (this.menuItemNum - 1);
	menuOpened = false;
	myIcon: "md-add" | "ios-arrow-down-outline" = "md-add";

	constructor(private nav: NavController, private elementRef: ElementRef, private translate: TranslateService) {

	}

	toggleMenu() {
		this.menuOpened = !this.menuOpened;

		this.myIcon = (this.menuOpened) ? "ios-arrow-down-outline" : "md-add";

		this.menuOpened ? this.openMenu() : this.closeMenu();
	}

	onNewWatch(){
		this.nav.push(WatchPage, {
			user:this.user
		});
		this.toggleMenu();
	}

	onDashboard(){
		this.nav.setRoot(DashboardPage, {
			user:this.user
		});
	}

	onAbout(){
		this.nav.push(AboutPage, {
			user:this.user
		});
	}

	onNewMeasure(){

		this.toggleMenu();

		if(this.user.watches.length > 0){
			let alert = Alert.create();
		    alert.setTitle(this.translate.instant('select-measure'));

		    for (var i = 0; i < this.user.watches.length; i++) {

		    	if(this.user.watches[i].next !== WatchAction.Waiting){
		    		alert.addInput({
				      type: 'radio',
				      label: this.user.watches[i].brand + " " + this.user.watches[i].name,
				      value: this.user.watches[i].id.toString()
				    });
		    	}

		    }

		    alert.addButton(this.translate.instant('cancel'));
		    alert.addButton({
		      text: this.translate.instant('ok'),
		      handler: data => {

		      	if(data !== undefined){
		      		let selectedWatch:Watch;
			      	for (var i = 0; i < this.user.watches.length; i++) {

						console.log("data", data);
			      		if(this.user.watches[i].id.toString() == data){
			      			selectedWatch = this.user.watches[i];
			      			console.log("sw", selectedWatch);
			      			break;
			      		}
			      	}

			      	this.nav.push(MeasurePage, {
						watch: selectedWatch,
						user: this.user
					});
		      	}else{

		      		alert.dismiss();
		      	}
		      }
		    });

		    this.nav.present(alert);
		}else{
			this.onNewWatch();
		}
		
	}

	openMenu() {

		let elements:any[] = this.elementRef.nativeElement.querySelectorAll(".menu-item");

		console.log(elements);

		for (var i = 0; i < elements.length; i++) {
			var delay: number = i * 0.08;

			var bounce = elements[i].querySelectorAll(".menu-item-bounce");
			var TweenMax = new TimelineMax();

			var Quad = new Quint();
			// var Elastic = new Elastic();
			var disance = 90;

			TweenMax.to(elements[i].querySelectorAll(".menu-item-button"), 0.1, {
				delay: delay,
				y: disance,
				force3D: true,
				ease: Quint.easeInOut
			});
		}
	}

	onTime(){
		this.nav.push(TimePage, {
			user:this.user
		});
	}

	onTips(){
		this.nav.push(TipsPage, {
			user: this.user
		});
	}

	onShare(){
		SocialSharing.share(
			this.translate.instant('generic-share'),
            'Toolwatch', 
            null, 
            "https://toolwatch.io"
		);
	}

	closeMenu() {

		let elements:any[] = this.elementRef.nativeElement.querySelectorAll(".menu-item");

		for (var i = 0; i < elements.length; i++) {
			var delay: number = i * 0.08;

			var bounce = elements[i].querySelectorAll(".menu-item-bounce");
			var TweenMax = new TimelineMax();
			var Quad = new Quint();
			// var Elastic = new Elastic();
			var disance = 90;
			
			TweenMax.to(elements[i].querySelectorAll(".menu-item-button"), 0.1, {
				delay: delay,
				y: 0,
				force3D: true,
				ease: Quint.easeIn
			});
		}
	}


	ngAfterViewInit() {

		let elements:any[] = this.elementRef.nativeElement.querySelectorAll(".menu-item");

		for (var i = 0; i < elements.length; i++) {
			let startingAngle: number = 180 + (-120 / 2);
			let slice: number = 120 / (3 - 1);


			let angle = startingAngle + (slice * i);

			elements[i].style.transform = "rotate(" + (angle) + "deg)";

			elements[i].querySelector(".menu-item-icon")
				.style.transform = "rotate(" + (-angle) + "deg)";
		}
	}

}