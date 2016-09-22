import {Loading, NavController, LoadingController, NavParams} from 'ionic-angular';

import {Component, ElementRef, forwardRef} from '@angular/core';

import {Footer} from '../../components/footer/footer';
import {Header}  from '../../components/header/header';
import { MoonPhases } from './moon/moon-phases'

import {
	TwAPIService,
	ClockComponent,
	User,
	GAService,
	LeadingZero,
	ArethmeticSign
} from 'tw-common/dist/app';

import {TranslateService, TranslatePipe} from 'ng2-translate/ng2-translate';

@Component({
	templateUrl: 'build/pages/time/time.html',
	pipes: [TranslatePipe, LeadingZero, ArethmeticSign],
	directives: [forwardRef(() => Footer), Header, MoonPhases]
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

		setInterval(()=>{
				this.date = new Date(this.date.getTime() + this.interval);
				this.initLocalClocks();
			}, 
			this.interval
		);

		this.user = this.navParams.get('user');

		document.addEventListener('resume', () => {
			this.ngAfterViewInit();
		});
	}

	ngAfterViewInit() {

		this.loading.present();
		
		this.twapi.accurateTime().then(
			date => {

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
