import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { LogInPage } from './login';

import { Facebook } from '@ionic-native/facebook';
import {
    LoginComponent,
    TwAPIService,
    AnalyticsService
} from 'tw-core';
import { TranslateService } from '@ngx-translate/core';
import { MobileError } from '../components/mobile-error/mobile-error';
import { MobileInput } from '../components/mobile-input/mobile-input';

@NgModule({
  declarations: [
      LogInPage, 
      LoginComponent,
      MobileError,
      MobileInput    
  ],
  imports: [IonicPageModule.forChild(LogInPage)],
  providers: [
    Facebook,
    TwAPIService,
    AnalyticsService
  ],
  exports:[LogInPage]
})
export class LoginPageModule { }