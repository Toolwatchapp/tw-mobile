import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { TimePage } from './time';

import { Facebook } from '@ionic-native/facebook';
import { HeaderComponentModule } from './../../components/header/header.module';
import { TranslateModule, TranslateLoader } from '@ngx-translate/core';
import { AppModule } from './../../app/app.module';
import { FooterComponentModule } from './../../components/footer/footer.module';

import {
  ArethmeticSignPipeModule,
  LeadingZeroPipeModule,
  MoonPhasesComponentModule,
  ClockComponentModule
} from 'tw-core';



@NgModule({
  declarations: [
    TimePage
  ],
  imports: [
    IonicPageModule.forChild(TimePage),
    HeaderComponentModule,
    ArethmeticSignPipeModule,
    LeadingZeroPipeModule,
    FooterComponentModule,
    ClockComponentModule,
    MoonPhasesComponentModule,
    AppModule.translateModule
  ],
  exports: [TimePage]
})
export class TimePageModule { }