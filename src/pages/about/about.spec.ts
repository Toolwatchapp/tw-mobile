import { async, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { IonicModule, Platform } from 'ionic-angular';

import { PlatformMock } from '../../../test-config/mocks-ionic';

import { AboutPage } from './about';

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


import { HeaderComponentModule } from './../../components/header/header.module';
import { FooterComponentModule } from './../../components/footer/footer.module';

import {
    TwAPIService,
    AnalyticsService,
    ConfigurationService
} from 'tw-core';


import { Pipe, PipeTransform } from '@angular/core';

class ApiMock {
    constructor() {
    }
}

describe('MyApp Component', () => {
    let fixture;
    let component: AboutPage;

    beforeEach(async(() => {
        TestBed.configureTestingModule({
            declarations: [AboutPage],
            imports: [
                IonicModule.forRoot(AboutPage),
                TranslateModule.forRoot(),
                HeaderComponentModule,
                FooterComponentModule,
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
        });
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(AboutPage);
        component = fixture.componentInstance;
    });

});