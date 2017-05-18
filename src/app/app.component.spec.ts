import { async, TestBed } from '@angular/core/testing';
import { IonicModule, Platform } from 'ionic-angular';

import { PlatformMock } from '../../test-config/mocks-ionic';

import { MyApp } from './app.component';


import { StatusBar } from '@ionic-native/status-bar';
import { SplashScreen } from '@ionic-native/splash-screen';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpModule, Http } from '@angular/http';
import { IonicStorageModule } from '@ionic/storage';
import { BrowserModule } from '@angular/platform-browser';
import { InAppBrowser } from '@ionic-native/in-app-browser';
import { Keyboard } from '@ionic-native/keyboard';
import { AppVersion } from '@ionic-native/app-version';
import { Facebook } from '@ionic-native/facebook';
import { SocialSharing } from '@ionic-native/social-sharing';
import { AppRate } from '@ionic-native/app-rate';

import { TranslateService, TranslateModule } from '@ngx-translate/core';

import {
    TwAPIService,
    AnalyticsService,
    ConfigurationService
} from 'tw-core';


import { Pipe, PipeTransform } from '@angular/core';

class ApiMock {
    constructor() {
        console.log("constructed");
    }
}

describe('MyApp Component', () => {
    let fixture;
    let component: MyApp;

    beforeEach(async(() => {
        TestBed.configureTestingModule({
            declarations: [MyApp],
            imports: [
                IonicModule.forRoot(MyApp),
                IonicStorageModule.forRoot(),
                TranslateModule.forRoot()
            ],
            providers: [
                StatusBar,
                SplashScreen,
                { provide: Platform, useClass: PlatformMock },
                { provide: TwAPIService, useClass: ApiMock },
                Keyboard,
                AppVersion,
                StatusBar,
                Facebook,
                SocialSharing,
                AppRate,
                InAppBrowser,
                AnalyticsService,
                Keyboard
            ]
        })
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(MyApp);
        component = fixture.componentInstance;
    });

    it('should be created', () => {
        expect(component instanceof MyApp).toBe(true);
    });

});