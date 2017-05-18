import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { MeasurePage } from './measure';

import { Facebook } from '@ionic-native/facebook';

import { HeaderComponentModule } from './../../components/header/header.module';
import { TranslateModule } from '@ngx-translate/core';

import {
    ArethmeticSignPipeModule,
    LeadingZeroPipeModule,
    KFormatterPipeModule
} from 'tw-core';


import { AppModule } from './../../app/app.module';

@NgModule({
  declarations: [
    MeasurePage
  ],
  imports: [
    IonicPageModule.forChild(MeasurePage),
    HeaderComponentModule,
    AppModule.translateModule,
    ArethmeticSignPipeModule,
    LeadingZeroPipeModule,
    KFormatterPipeModule
  ],
  exports: [MeasurePage]
})
export class MeasurePageModule { }