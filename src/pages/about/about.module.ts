import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { AboutPage } from './about';

import { HeaderComponentModule } from './../../components/header/header.module';
import { FooterComponentModule } from './../../components/footer/footer.module';
import { AppModule } from './../../app/app.module';

@NgModule({
  declarations: [AboutPage],
  imports: [
    IonicPageModule.forChild(AboutPage),
    HeaderComponentModule,
    FooterComponentModule,
    AppModule.translateModule
  ],
  exports: [AboutPage]
})
export class AboutPageModule { }