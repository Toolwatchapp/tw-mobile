import 'gsap';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import {Component, ElementRef, ViewChild} from '@angular/core';


declare var TimelineMax: any;
declare var Quint: any;
declare var Quad: any;
declare var Elastic: any;

@Component({
	templateUrl: 'build/pages/footer/footer.html',
	pipes: [TranslatePipe],
	selector: "footer-nav"
})
export class Footer {

	tl = new TimelineMax();
	qt = new Quint();
	menuItemNum: number = 3;
	angle: number = 120;
	distance: number = 90;
	startingAngle: number = 180 + (-this.angle / 2);
	slice: number = this.angle / (this.menuItemNum - 1);
	menuOpened = false;
	myIcon: "md-add" | "ios-arrow-down-outline" = "md-add";

	constructor(private elementRef: ElementRef, private translate: TranslateService){

	}

	toggleMenu() {
		this.menuOpened = !this.menuOpened;

		this.myIcon = (this.menuOpened) ? "ios-arrow-down-outline" : "md-add";


		this.menuOpened ? this.openMenu() : this.closeMenu();
	}

	openMenu() {

		this.elementRef.nativeElement.querySelectorAll(".menu-item")
			.forEach(function(element: any, index: number) {

				var delay: number = index * 0.08;

				var bounce = element.querySelectorAll(".menu-item-bounce");
				var TweenMax = new TimelineMax();

				var Quad = new Quint();
				// var Elastic = new Elastic();
				var disance = 90;

				TweenMax.fromTo(bounce, 0.1, {
					transformOrigin: "50% 50%"
				}, {
						delay: delay,
						scaleX: 0.8,
						scaleY: 1.2,
						force3D: true,
						ease: Quad.easeInOut,
						onComplete: function() {
							TweenMax.to(bounce, 0.15, {
								// scaleX:1.2,
								scaleY: 0.7,
								force3D: true,
								ease: Quad.easeInOut,
								onComplete: function() {
									TweenMax.to(bounce, 0, {
										scaleX: 1.65,
										scaleY: 1.65,
										force3D: true,
										ease: Elastic.easeOut,
										easeParams: [1.1, 0.12]
									})
								}
							})
						}
					});

				TweenMax.to(element.querySelectorAll(".menu-item-button"), 0.1, {
					delay: delay,
					y: disance,
					force3D: true,
					ease: Quint.easeInOut
				});
			});

	}

	closeMenu() {

		this.elementRef.nativeElement.querySelectorAll(".menu-item")
			.forEach(function(element: any, index: number) {

				var delay: number = index * 0.08;

				var bounce = element.querySelectorAll(".menu-item-bounce");
				var TweenMax = new TimelineMax();
				var Quad = new Quint();
				// var Elastic = new Elastic();
				var disance = 90;

				TweenMax.fromTo(bounce, 0.1, {
					transformOrigin: "50% 50%"
				}, {
						delay: delay,
						scaleX: 1,
						scaleY: 0.8,
						force3D: true,
						ease: Quad.easeInOut,
						onComplete: function() {
							TweenMax.to(bounce, 0.15, {
								// scaleX:1.2,
								scaleY: 1.2,
								force3D: true,
								ease: Quad.easeInOut,
								onComplete: function() {
									TweenMax.to(bounce, 3, {
										// scaleX:1,
										scaleY: 1,
										force3D: true,
										ease: Elastic.easeOut,
										easeParams: [1.1, 0.12]
									})
								}
							})
						}
					});


				TweenMax.to(element.querySelectorAll(".menu-item-button"), 0.1, {
					delay: delay,
					y: 0,
					force3D: true,
					ease: Quint.easeIn
				});
			});
	}


	ngAfterViewInit() {
		this.elementRef.nativeElement.querySelectorAll(
			'.menu-item'
		).forEach(function(element: any, index: number) {

			let startingAngle: number = 180 + (-120 / 2);
			let slice: number = 120 / (3 - 1);


			let angle = startingAngle + (slice * index);

			element.style.transform = "rotate(" + (angle) + "deg)";

			element.querySelector(".menu-item-icon")
				.style.transform = "rotate(" + (-angle) + "deg)";
		});
	}

}