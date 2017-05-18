import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { WatchPage } from './watch';

import { Facebook } from '@ionic-native/facebook';

import { HeaderComponentModule } from './../../components/header/header.module';
import { TranslateModule } from '@ngx-translate/core';
import { MobileErrorComponentModule } from './../../components/mobile-error/mobile-error.module';
import { MobileInputComponentModule } from './../../components/mobile-input/mobile-input.module';
import { AppModule } from './../../app/app.module';

@NgModule({
  declarations: [
    WatchPage
  ],
  imports: [
    IonicPageModule.forChild(WatchPage),
    HeaderComponentModule,
    MobileErrorComponentModule,
    MobileInputComponentModule,
    AppModule.translateModule
  ],
  exports: [WatchPage]
})
export class WatchPageModule { }