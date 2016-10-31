import { NgModule } from '@angular/core';
import { IonicApp, IonicModule } from 'ionic-angular';
import { MyApp } from './app.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpModule, Http } from '@angular/http';


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

import { 
  ArethmeticSign, 
  LeadingZero,
  TwAPIService,
  GAService,
  ClockComponent,
  MoonPhasesComponent,
  LoginComponent,
  SignupComponent,
  WatchComponent
} from '../share/src/app';


//Common Pipes
import { TranslateModule, TranslateStaticLoader, TranslateLoader } from 'ng2-translate/ng2-translate';

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
    ArethmeticSign,
    LeadingZero,
    ClockComponent,
    MoonPhasesComponent,
    LoginComponent,
    SignupComponent,
    WatchComponent,
    Footer,
    Header,
    MobileError,
    MobileInput
  ],
  imports: [
    IonicModule.forRoot(MyApp),
    FormsModule,
    HttpModule,
    ReactiveFormsModule,
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
  providers: [TwAPIService, GAService]
})
export class AppModule {}

export function createTranslateLoader(http: Http) {
    return new TranslateStaticLoader(http, './assets/i18n', '.json');
}