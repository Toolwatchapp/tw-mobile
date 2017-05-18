import { NgModule } from '@angular/core';
import { IonicModule } from 'ionic-angular';
import { MobileError } from './mobile-error';
import { TranslateModule } from '@ngx-translate/core';

@NgModule({
  declarations: [MobileError],
  imports: [
    IonicModule,
    TranslateModule.forChild()
  ],
  exports: [MobileError]
})
export class MobileErrorComponentModule { }