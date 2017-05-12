import { NavController } from 'ionic-angular';
import { Component, Input } from '@angular/core';
import { InAppBrowser } from '@ionic-native/in-app-browser';

import {
    AnalyticsService
} from 'tw-core';

@Component({
    templateUrl: 'header.html',
    selector: "header-nav"
})
export class Header {

    @Input()
    slogan: string = "slogan";
    @Input()
    chat: boolean = true;
    @Input()
    back: boolean = false;
    @Input()
    topBg: string = "handBg";

    constructor(
       private nav: NavController,
       private iab: InAppBrowser
    ) {}

    onBack() {
       this.nav.pop();
    }

    onChat() {
       this.iab.create('https://go.crisp.im/chat/embed/?website_id=-K4rBEcM_Qbt6JrISVzu', '_blank');

       /**
            * Don't do inject if user isn't logged yet
        */
       // if(GAService.userEmail != null && GAService.userName != null){


       //     let script:string = ''
       //     +    '$crisp.set("user:email", "'+ GAService.userEmail +'");'
       //     +    '$crisp.set("user:nickname", "'+   GAService.userName +'");'
       //     +''
       //     browser.executeScript({code: script});
       // }
    }
}