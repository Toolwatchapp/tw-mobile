import {Component, ElementRef, ViewChild} from '@angular/core';
import {Alert, Nav, Loading, NavController, NavParams} from 'ionic-angular';
import {TwAPIService} from 'tw-common/dist/app/services/twapi.service';
import {Watch, WatchStatus, WatchAction} from 'tw-common/dist/app/models/watch.model';
import {Measure} from 'tw-common/dist/app/models/measure.model';
import {User} from 'tw-common/dist/app/models/user.model';
import {WatchComponent} from 'tw-common/dist/app/directives/watch/watch.component';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import {Http, HTTP_PROVIDERS, Headers}  from '@angular/http';
import {DashboardPage} from '../dashboard/dashboard';
import {FORM_DIRECTIVES, FormBuilder, Control, ControlGroup, Validators}  from '@angular/common';
import {Header}  from '../header/header';
import 'gsap';

@Component({
	templateUrl: 'build/pages/measure/measure.html',
	pipes: [TranslatePipe],
	providers: [TwAPIService, HTTP_PROVIDERS],
	directives: [Header]
})
export class MeasurePage {
	
	user:User;
	watch:Watch;
	offsetedDate:Date;
	offsetedDateString:string;
	referenceTime:Date;
	accuracy:number;
	percentage:number;
	step = 0;

	constructor(private nav: NavController, private navParams: NavParams, 
		private translate: TranslateService,
		private twapi: TwAPIService) {

		this.user = this.navParams.get('user');
		this.watch = this.navParams.get('watch');
	}

	validate(){
		if (this.watch.next === WatchAction.Measure) {

			this.twapi.upsertMeasure(
				this.watch, 
				new Measure(null, this.referenceTime.getTime(), this.offsetedDate.getTime())
			).then(
				watch => {
					this.watch = watch;
					this.watch.next = WatchAction.Waiting;
					this.watch.currentMeasure().accuracy = 12;
					this.step = 2;
				}
			);
		}else{
			this.watch.currentMeasure().addAccuracyMeasure(
				this.offsetedDate.getTime(), this.referenceTime.getTime()
			);

			this.twapi.upsertMeasure(
				this.watch,
				new Measure(null, this.referenceTime.getTime(), this.offsetedDate.getTime())
			).then(
				watch => {
					this.watch = watch;
					this.accuracy = watch.currentMeasure().accuracy;
					this.percentage = watch.currentMeasure().percentile;
					this.step = 3;
				}
			);
		}
	}

	leave(){

		this.user.upsertWatch(this.watch);
		this.nav.pop({
			user:this.user
		});
	}

	measure(){

		this.step = 1;
		this.twapi.accurateTime().then(
			time => this.referenceTime = time
		);
	}

	retrieveMinute(){
		this.offsetedDate = new Date(this.offsetedDate .getTime() - 60 * 1000);
		this.offsetedDateString = this.constructoffsetedDateString();
	}

	addMinute() {
		this.offsetedDate = new Date(this.offsetedDate.getTime() + 60 * 1000);
		this.offsetedDateString = this.constructoffsetedDateString();
	}

	ngAfterViewInit() {

		let times = 10;
		let completed = 0;
		let text = this.translate.instant('sync');
		let loading = Loading.create({
			content: text
		});

		this.nav.present(loading);

		this.twapi.accurateTime(function(){
			completed++;
			loading.setContent(text + "(" + completed/10*100 + "%)");
		}).then(
			res => {
				loading.dismiss();
				let d = res;
				let seconds = d.getSeconds();
				let offsetSeconds = 0;

				// If it's somewhere between xx:xx:51 and xx:xx:60,
				// users won't have the time to click.
				// So, we add a minute.
				if (seconds >= 50) {
					offsetSeconds = 60 - seconds;
				} else {
					offsetSeconds = -seconds;
				}

				this.offsetedDate = new Date(d.getTime() + offsetSeconds * 1000 + 60 * 1000);
				this.offsetedDateString = this.constructoffsetedDateString();
			}
		);
	}

	private constructoffsetedDateString():string{
		var hours = (this.offsetedDate.getHours() < 10) ? "0" + this.offsetedDate.getHours() :
			this.offsetedDate.getHours();

		var minutes = (this.offsetedDate.getMinutes() < 10) ? "0" + this.offsetedDate.getMinutes() :
			this.offsetedDate.getMinutes();

		var seconds = (this.offsetedDate.getSeconds() < 10) ? "0" + this.offsetedDate.getSeconds() :
			this.offsetedDate.getSeconds();

		return hours + ":" + minutes + ":" + seconds;
	}


}
