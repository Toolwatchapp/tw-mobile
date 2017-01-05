import {Loading, NavController, LoadingController, NavParams} from 'ionic-angular';

import {Component, ElementRef} from '@angular/core';

import {
	TwAPIService,
	ClockComponent,
	User,
	GAService
} from 'tw-core';

import {TranslateService} from 'ng2-translate/ng2-translate';

@Component({
	templateUrl: 'time.html'
})
export class TimePage extends ClockComponent{
	
	//So I can use the math lib in the view
	//for rounding milliseconds
	Math:any = Math;
	interval:number = 100;
	offset:number;
	user:User;
	background:string = "time-background";
	loading:Loading; 
	twelveHoursFormat:boolean = true;

	constructor(
		//own injection
		private nav: NavController, 
		private navParams: NavParams,
		private twapi: TwAPIService, 
		private translate: TranslateService,
		private loadingController: LoadingController,
		//injection for ClockComponent
		elementRef: ElementRef
	) {

		super(elementRef);

		this.loading = this.loadingController.create({
			content: this.translate.instant('sync'),
			dismissOnPageChange: false
		});

    	GAService.screenview("TIME");

		this.user = this.navParams.get('user');

		document.addEventListener('resume', () => {
			this.ngAfterViewInit();
		});
	}

	ngAfterViewInit() {

		this.loading.present();
		
		this.twapi.accurateTime().then(
			date => {

				setInterval(()=>{
						this.date = new Date(this.date.getTime() + this.interval);
						this.initLocalClocks();
					}, 
					this.interval
				);

				setTimeout(()=>{
			      this.loading.dismiss()
			   	});

				this.date = date;
				this.initLocalClocks();
				this.offset = this.twapi.getOffsetTime();
			}
		);
	}

}
