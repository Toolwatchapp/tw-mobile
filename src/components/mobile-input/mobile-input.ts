import { Component, Input, EventEmitter, Output } from '@angular/core';
import {   
  FormControl
} from '@angular/forms';

/*
  Generates a mobile form input

  See https://angular.io/docs/ts/latest/api/core/DirectiveMetadata-class.html
  for more info on Angular 2 Directives.
*/
@Component({
    templateUrl: 'mobile-input.html',
    selector: 'mobile-input',
})
export class MobileInput {

    @Input()
    id: string;
    @Input()
    control: FormControl;
    @Input()
    model: boolean = false;
    @Input()
    type: string = "text";
    @Input()
    label: string;
    @Input()
    errorLabel: string;
    @Input()
    formControlNam: string;
    @Input()
    submitAttempt: boolean = true;
    @Input()
    autoCapitalize: boolean = true;
    @Input()
    autoCorrect: boolean = true;
    @Input()
    autoComplete: boolean = true;
    @Input()
    spellCheck: boolean = true;

    @Input()
    value: string = "";
    @Output()
    valueChange = new EventEmitter();

    isFocused = false;

    ngOnInit() {

        if(this.control === null || this.id === null
            || this.control === undefined || this.id === undefined) {
            throw "[Control] and [id] must be set";
        }

        //initialize other variables to the value of id 
        //if they are null
        let variablesToInitialize = [
            "label", 
            "errorLabel", 
            "formControlName"
        ];

        for (var i = variablesToInitialize.length - 1; i >= 0; i--) {
            if(this[variablesToInitialize[i]] == null) {
               this[variablesToInitialize[i]] = this.id;
            }
        }
    }

    toggleFocus():void {
       this.isFocused = !this.isFocused;
    }

    emitChange(event):void {
       this.value = event.target.value;
       this.valueChange.emit(event);
    }

    isActive():boolean {
       return this.isFocused || (this.value !== null && this.value.length !== 0); 
    }
}