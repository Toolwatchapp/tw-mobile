import { Component, Input, EventEmitter, Output  } from '@angular/core';
import {   
  FormControl
} from '@angular/forms';


import {TranslatePipe} from 'ng2-translate/ng2-translate';
/*
  Generates a mobile form input

  See https://angular.io/docs/ts/latest/api/core/DirectiveMetadata-class.html
  for more info on Angular 2 Directives.
*/
@Component({
	templateUrl: 'build/components/mobile-input/mobile-input.html',
	pipes: [TranslatePipe],
	selector: 'mobile-input',
})
export class MobileInput {

	@Input()
	id             : string;
	@Input()
	control        : FormControl;
	@Input()
	model          : any = null;
	@Input()
	type           : string = "text";
	@Input()
	label          : string;
	@Input()
	errorLabel     : string;
	@Input()
	formControlName: string;
	@Input()
	submitAttempt  : boolean = true;
	@Input()
	autoCapitalize : boolean = true;
	@Input()
	autoCorrect    : boolean = true;
	@Input()
	autoComplete   : boolean = true;
	@Input()
	spellCheck     : boolean = true;
	
	@Output()
	update         = new EventEmitter();

	constructor() {
	    
	}
	    /**
	   * Pull the brands
	   */
	ngAfterViewInit() {

	    if(this.control == null || this.id == null){
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
	    	if(this[variablesToInitialize[i]] == null){
	    		this[variablesToInitialize[i]] = this.id;
	    	}
	    }
	}

}
