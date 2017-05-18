import { AlertController, NavController, NavParams, IonicPage } from 'ionic-angular';

import { Component } from '@angular/core';
import { FormBuilder } from '@angular/forms';

import {
    TwAPIService,
    Watch,
    WatchComponent,
    AnalyticsService
} from 'tw-core';

import { DashboardPage } from '../dashboard/dashboard';

import { TranslateService } from '@ngx-translate/core';

@IonicPage({
  name: 'WatchPage',
  segment: 'WatchPage'
})
@Component({
    templateUrl: 'watch.html'
})
export class WatchPage extends WatchComponent {

    background: string = "addWatch-background";
    slogan: string = "add-new-watch";
    errors = [];

    constructor(
        //Own injections
        private nav: NavController,
        private navParams: NavParams,
        private alertController: AlertController,
        private analytics: AnalyticsService,
        //Injections for WatchComponent
        translate: TranslateService,
        twapi: TwAPIService,
        builder: FormBuilder
    ) {

        super(translate, twapi, builder);

        this.analytics.screenview("WATCH");

        this.user = this.navParams.get('user');

        this.watchSaved.subscribe(
            user => {
                DashboardPage.userChanged.emit(user);
                this.nav.pop();
            }
        );

        let receivedWatch: Watch = this.navParams.get('watch');
        if (receivedWatch !== undefined) {
            this.watchModel = receivedWatch.clone();
        }

    }

    onSubmit() {
        super.onSubmit();
        if (this.error === true) {
            let alert = this.alertController.create({
                title: this.translate.instant('watch-add-error'),
                buttons: ['OK']
            });
            alert.present();
        }
    }

    /**
     * Preempt delete action to present a confirmation popup
     */
    onDelete() {
        let alert = this.alertController.create({
            title: this.translate.instant('delete-watch-alert'),
            message: this.translate.instant('delete-watch-confirm') + this.watchModel.brand + " " + this.watchModel.name + "?",
            buttons:
            [
                {
                    text: this.translate.instant('cancel'),
                    role: 'cancel',
                    handler: () => {
                        console.log('Cancel clicked');
                    }
                },
                {
                    text: this.translate.instant('confirm'),
                    handler: () => {

                        super.onDelete();
                    }
                }
            ]
        });
        alert.present();
    }
}