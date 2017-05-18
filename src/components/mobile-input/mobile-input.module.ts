import { NgModule } from '@angular/core';
import { IonicModule } from 'ionic-angular';
import { MobileInput } from './mobile-input';
import { TranslateModule } from '@ngx-translate/core';

@NgModule({
  declarations: [MobileInput],
  imports: [
    IonicModule,
    TranslateModule.forChild()
  ],
  exports: [MobileInput]
})
export class MobileInputComponentModule { }