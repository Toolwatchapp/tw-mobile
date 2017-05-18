import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { TipsPage } from './tips';

import { Facebook } from '@ionic-native/facebook';

import { HeaderComponentModule } from './../../components/header/header.module';
import { AppModule } from './../../app/app.module';
import { FooterComponentModule } from './../../components/footer/footer.module';

@NgModule({
  declarations: [
    TipsPage
  ],
  imports: [
    IonicPageModule.forChild(TipsPage),
    HeaderComponentModule,
    FooterComponentModule,
    AppModule.translateModule
  ],
  exports: [TipsPage]
})
export class TipsPageModule { }