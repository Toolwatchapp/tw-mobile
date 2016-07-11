import {Component, ElementRef, forwardRef} from '@angular/core';
import {Nav, Loading, NavController, NavParams} from 'ionic-angular';
import {TwAPIService} from 'tw-common/dist/app/services/twapi.service';
import {BlogPost} from 'tw-common/dist/app/models/blog-post.model';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import { HTTP_PROVIDERS }  from '@angular/http';
import {Header}  from '../header/header';
import {ClockComponent} from 'tw-common/dist/app/directives/clock/clock.component';
import {MoonPhases} from './moon/moon-phases';
import {Footer} from '../footer/footer';
import {User} from 'tw-common/dist/app/models/user.model';


@Component({
	templateUrl: 'build/pages/time/time.html',
	pipes: [TranslatePipe],
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

	constructor(elementRef: ElementRef, private nav: NavController, private navParams: NavParams,
		private twapi: TwAPIService, private translate: TranslateService) {

		super(elementRef);

		this.twapi.accurateTime().then(
			date => {
				this.date = date;
				this.initLocalClocks();
				this.offset = this.twapi.getOffsetTime();
			}
		);

		setInterval(
			function(interval:number, me:TimePage):void{
				me.date = new Date(me.date.getTime() + interval);
			}, 
			this.interval, this.interval, this
		);

		this.user = this.navParams.get('user');
	}

	addZero(i:number):string {
	    if (i < 10) {
	        return "0" + i;
	    }else{
	    	return i.toString();
	    }
	}

	addSign(i:number):string{
		if(i >= 0){
			return "+" + i;
		}
	}



}