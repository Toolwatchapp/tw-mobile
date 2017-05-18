import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { DashboardPage } from './dashboard';

import { HeaderComponentModule } from './../../components/header/header.module';
import { FooterComponentModule } from './../../components/footer/footer.module';

import { AppModule } from './../../app/app.module';

import {
    ArethmeticSignPipeModule,
    LeadingZeroPipeModule,
    KFormatterPipeModule
} from 'tw-core';


@NgModule({
    declarations: [DashboardPage],
    imports: [
        IonicPageModule.forChild(DashboardPage),
        HeaderComponentModule,
        FooterComponentModule,
        ArethmeticSignPipeModule,
        LeadingZeroPipeModule,
        KFormatterPipeModule,
        AppModule.translateModule
    ],
    exports: [DashboardPage]
})
export class DashboardPageModule { }