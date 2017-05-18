import { NgModule } from '@angular/core';
import { IonicModule } from 'ionic-angular';
import { Header } from './header';
import { TranslateModule } from '@ngx-translate/core';
import { AppModule } from './../../app/app.module';

@NgModule({
  declarations: [Header],
  imports: [
    IonicModule,
    AppModule.translateModule
  ],
  exports: [Header]
})
export class HeaderComponentModule { }