import { NgModule, ErrorHandler } from '@angular/core';
import { IonicApp, IonicModule, IonicErrorHandler } from 'ionic-angular';
import { MyApp } from './app.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpModule, Http } from '@angular/http';
import { IonicStorageModule  } from '@ionic/storage';
import {BrowserModule} from '@angular/platform-browser';

//Ionic Pages
import { AboutPage } from '../pages/about/about';
import { DashboardPage } from '../pages/dashboard/dashboard';
import { LogInPage } from '../pages/login/login';
import { MeasurePage } from '../pages/measure/measure';
import { SignupPage } from '../pages/signup/signup';
import { TimePage } from '../pages/time/time';
import { TipsPage } from '../pages/tips/tips';
import { WatchPage } from '../pages/watch/watch';

//Mobile Components
import { Footer } from '../components/footer/footer';
import { Header } from '../components/header/header';
import { MobileError } from '../components/mobile-error/mobile-error';
import { MobileInput } from '../components/mobile-input/mobile-input';

import { TranslateModule, TranslateLoader, TranslateStaticLoader } from 'ng2-translate/ng2-translate';

import { TwAPIService, GAService } from 'tw-core';
import { TwCoreModule } from 'tw-core';

export function createTranslateLoader(http: Http) {
    return new TranslateStaticLoader(http, './assets/i18n', '.json');
}


@NgModule({
  declarations: [
    MyApp,
    AboutPage,
    DashboardPage,
    LogInPage,
    MeasurePage,
    SignupPage,
    TimePage,
    WatchPage,
    TipsPage,
    Footer,
    Header,
    MobileError,
    MobileInput
  ],
  imports: [
    TwCoreModule,
    IonicModule.forRoot(MyApp),
    FormsModule,
    ReactiveFormsModule,
    BrowserModule,
    HttpModule,
    IonicStorageModule.forRoot(),
    TranslateModule.forRoot({ 
          provide: TranslateLoader,
          useFactory: (createTranslateLoader),
          deps: [Http]
    })
  ],
  exports: [HttpModule, TranslateModule],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,
    AboutPage,
    DashboardPage,
    LogInPage,
    MeasurePage,
    SignupPage,
    TimePage,
    TipsPage,
    WatchPage
  ],
  providers: [{provide: ErrorHandler, useClass: IonicErrorHandler}, Storage, TwAPIService, GAService]
})
export class AppModule {}