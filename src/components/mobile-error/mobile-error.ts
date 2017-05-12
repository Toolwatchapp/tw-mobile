import { Component, Input } from '@angular/core';

/*
  Generated class for the MobileError component.

  See https://angular.io/docs/ts/latest/api/core/ComponentMetadata-class.html
  for more info on Angular 2 Components.
*/
@Component({
  selector: 'mobile-error',
  templateUrl: 'mobile-error.html'
})
export class MobileError {

  @Input()
  errors: [string];

  constructor() {
  }
}