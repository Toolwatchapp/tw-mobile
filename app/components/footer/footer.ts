import {
	Alert,
	AlertController,
	Nav,
	Loading,
	NavParams,
	NavController
} from 'ionic-angular';
import {SocialSharing} from 'ionic-native';

import {
	Component,
	ElementRef,
	ViewChild,
	Input
} from '@angular/core';

import {WatchPage} from '../../pages/watch/watch';
import {TipsPage} from '../../pages/tips/tips';
import {TimePage} from '../../pages/time/time';
import {MeasurePage}  from '../../pages/measure/measure';
import {AboutPage}  from '../../pages/about/about';
import {DashboardPage}  from '../../pages/dashboard/dashboard';
import {Header}  from '../header/header';

import {
	User, 
	Watch, 
	WatchAction, 
	TwAPIService
} from 'tw-common/dist/app';

import {
	TranslateService,
	TranslatePipe
} from 'ng2-translate/ng2-translate';
import 'gsap';


declare var TimelineMax: any;
declare var Quint: any;
declare var Quad: any;
declare var Elastic: any;
declare var window;

@Component({
	templateUrl: 'build/components/footer/footer.html',
	pipes: [TranslatePipe],
	selector: "footer-nav"
})
export class Footer {

	@Input()
	user: User;

	tl = new TimelineMax();
	qt = new Quint();
	menuItemNum: number = 3;
	angle: number = 120;
	distance: number = 90;
	startingAngle: number = 180 + (-this.angle / 2);
	slice: number = this.angle / (this.menuItemNum - 1);
	menuOpened = false;
	myIcon: "md-add" | "ios-arrow-down-outline" = "md-add";

	constructor(
		private nav: NavController,
		private elementRef: ElementRef,
		private translate: TranslateService,
		private alertController: AlertController
	) { }

	/**
	 * Toggle the menu
	 */
	toggleMenu() {

		//Reverse menu
		this.menuOpened = !this.menuOpened;

		//Reverse icon
		this.myIcon = (this.menuOpened) ? "ios-arrow-down-outline" : "md-add";

		this.menuOpened ? this.openMenu() : this.closeMenu();
	}

	/**
	 * Show WatchPage
	 */
	onNewWatch() {
		this.nav.push(WatchPage, {
			user: this.user
		});
		this.toggleMenu();
	}

	/**
	 * Show DashboardPage
	 */
	onDashboard() {
		this.nav.setRoot(DashboardPage, {
			user: this.user
		});
	}

	/**
	 * Show AboutPage
	 */
	onAbout() {
		this.nav.push(AboutPage, {
			user: this.user
		});
	}

	/**
	 * Display watches that can be measured 
	 * or redirected to the WatchPage if no 
	 * watch can be measured.
	 */
	onNewMeasure() {

		//Close the menu for coherence here.
		this.toggleMenu();

		if (this.user.watches.length > 0) {
			this.showSelectWatchAlert();
		} else {
			this.onNewWatch();
		}

	}

	/**
	 * Opens the menu
	 */
	openMenu() {

		let elements: any[] = this.elementRef.nativeElement.querySelectorAll(".menu-item");

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

	/**
	 * Shows TimePage
	 */
	onTime() {
		this.nav.push(TimePage, {
			user: this.user
		});
	}
	/**
	 * Shows TipsPage
	 */
	onTips() {
		this.nav.push(TipsPage, {
			user: this.user
		});
	}
	/**
	 * Shows Share options
	 */
	onShare() {
		SocialSharing.share(
			this.translate.instant('generic-share'),
            'Toolwatch',
            null,
            "https://toolwatch.io"
		);
	}

	/**
	 * Closes the menu
	 */
	closeMenu() {

		let elements: any[] = this.elementRef.nativeElement.querySelectorAll(".menu-item");

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
	/**
	 * Inits the menu
	 */
	ngAfterViewInit() {

		let elements: any[] = this.elementRef.nativeElement.querySelectorAll(".menu-item");

		for (var i = 0; i < elements.length; i++) {
			let startingAngle: number = 180 + (-120 / 2);
			let slice: number = 120 / (3 - 1);


			let angle = startingAngle + (slice * i);

			elements[i].style.transform = "rotate(" + (angle) + "deg)";

			elements[i].querySelector(".menu-item-icon")
				.style.transform = "rotate(" + (-angle) + "deg)";
		}
	}

		/**
	 * Build and present an alert composed of watches with checkboxes
	 */
	private showSelectWatchAlert() {
		let alert = this.alertController.create();

		alert.setTitle(this.translate.instant('select-measure'));
		alert.addButton(this.translate.instant('cancel'));
		this.addWatchesToAlert(alert);

		alert.addButton({
			text: this.translate.instant('ok'),
			handler: data => this.onSelectedWatch(alert, data)
		});

		alert.present();
	}

	/**
	 * Determines which watch was selected and redirects to the 
	 * measure page 
	 * 
	 * @param {Alert}  alert     
	 * @param {String} selectedId
	 */
	private onSelectedWatch(alert: Alert, selectedId: String) {

		//If the user closes the alert 
		if (selectedId !== undefined) {
			let selectedWatch: Watch;

			//Find the selected one.
			for (var i = 0; i < this.user.watches.length; i++) {

				if (this.user.watches[i].id.toString() == selectedId) {
					selectedWatch = this.user.watches[i];
					break;
				}
			}

			//And away we go
			this.nav.push(MeasurePage, {
				watch: selectedWatch,
				user: this.user
			});
		} else {

			alert.dismiss();
		}
	}

	/**
	 * Constructs radio button w/ brands and name
	 * @param {Alert} alert
	 */
	private addWatchesToAlert(alert: Alert) {
		for (var i = 0; i < this.user.watches.length; i++) {

			if (this.user.watches[i].next !== WatchAction.Waiting) {
				alert.addInput({
					type: 'radio',
					label: this.user.watches[i].brand + " " + this.user.watches[i].name,
					value: this.user.watches[i].id.toString()
				});
			}

		}
	}

}