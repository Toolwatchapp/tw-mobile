import { Component, Input } from '@angular/core';

import {TranslatePipe} from 'ng2-translate/ng2-translate';

/*
  Generated class for the MobileError component.

  See https://angular.io/docs/ts/latest/api/core/ComponentMetadata-class.html
  for more info on Angular 2 Components.
*/
@Component({
  selector: 'mobile-error',
  pipes: [TranslatePipe],
  templateUrl: 'build/components/mobile-error/mobile-error.html'
})
export class MobileError {

	@Input()
	errors: {flag:boolean, label:string}[];

    constructor() {
    }
}
