import { NgModule, ErrorHandler } from '@angular/core';
import { IonicApp, IonicModule, IonicErrorHandler } from 'ionic-angular';
import { MyApp } from './app.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpModule, Http } from '@angular/http';
import { IonicStorageModule  } from '@ionic/storage';
import { BrowserModule } from '@angular/platform-browser';

import { InAppBrowser } from '@ionic-native/in-app-browser';
import { SplashScreen } from '@ionic-native/splash-screen';
import { Keyboard } from '@ionic-native/keyboard';
import { AppVersion } from '@ionic-native/app-version';
import { StatusBar } from '@ionic-native/status-bar';
import { Facebook } from '@ionic-native/facebook';
import { SocialSharing } from '@ionic-native/social-sharing';
import { AppRate } from '@ionic-native/app-rate';
//Ionic Pages
import { AboutPage } from '../pages/about/about';
import { DashboardPage } from '../pages/dashboard/dashboard';
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

import { TranslateModule, TranslateLoader } from '@ngx-translate/core';
import { TranslateHttpLoader } from '@ngx-translate/http-loader';

import { 
    TwAPIService,     
    ArethmeticSign,
    LeadingZero,
    KFormatter,
    MoonPhasesComponent,
    TwCoreModule,
    AnalyticsService,
    ConfigurationService, 
    configurationProvider
} from 'tw-core';

// The translate loader needs to know where to load i18n files
// in Ionic's static asset pipeline.
export function HttpLoaderFactory(http: Http) {
  return new TranslateHttpLoader(http, './assets/i18n/', '.json');
}

export function ConfigurationFactory() {
  return configurationProvider("a", "b");
}

@NgModule({
  declarations: [
    MyApp,
    AboutPage,
    DashboardPage,
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
    IonicModule.forRoot(MyApp, {}, {
      links: [
        { component: AboutPage, name: 'AboutPage', segment: 'About' },
        { component: DashboardPage, name: 'DashboardPage', segment: 'Dashboard' },
        { component: MeasurePage, name: 'MeasurePage', segment: 'Measure' },
        { component: SignupPage, name: 'SignupPage', segment: 'Signup' },
        { component: TimePage, name: 'TimePage', segment: 'Time' },
        { component: WatchPage, name: 'WatchPage', segment: 'Watch' },
        { component: TipsPage, name: 'TipsPage', segment: 'Tips' }
      ]
    }),
    IonicStorageModule.forRoot(),
    BrowserModule,
    TranslateModule.forRoot({
      loader: {
        provide: TranslateLoader,
        useFactory: HttpLoaderFactory,
        deps: [Http]
      }
    }),
    HttpModule,
    TwCoreModule
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,
    AboutPage,
    DashboardPage,
    MeasurePage,
    SignupPage,
    TimePage,
    TipsPage,
    WatchPage
  ],
  providers: [
    // {provide: ErrorHandler, useClass: IonicErrorHandler}, 
    TwAPIService, 
    InAppBrowser,
    AnalyticsService,
    {provide: ConfigurationService, useFactory: ConfigurationFactory}, 
    SplashScreen,
    Keyboard,
    AppVersion,
    StatusBar,
    Facebook,
    SocialSharing,
    AppRate
  ]
})
export class AppModule {}