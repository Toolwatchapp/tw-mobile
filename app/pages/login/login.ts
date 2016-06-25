import {Component, ViewChild} from '@angular/core';
import {Nav, Loading, NavController} from 'ionic-angular';
import {LoginComponent} from 'tw-common/dist/app/directives/login/login.component';
import {FORM_DIRECTIVES, FormBuilder, Control, ControlGroup, Validators}  from '@angular/common';
import {TwAPIService} from 'tw-common/dist/app/services/twapi.service';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import {Http, HTTP_PROVIDERS, Headers}  from '@angular/http';
import {DashboardPage} from '../dashboard/dashboard';
import {Header} from '../header/header';



@Component({
	templateUrl: 'build/pages/login/login.html',
	pipes: [TranslatePipe],
	providers: [TwAPIService, HTTP_PROVIDERS],
	directives: [Header]
})
export class LogInPage extends LoginComponent {



	constructor(private nav: NavController, translate: TranslateService,
		twapi: TwAPIService, builder: FormBuilder) {
		super(translate, twapi, builder);

	
		this.userLogged.subscribe(
			event => this.nav.setRoot(DashboardPage)
		);
	}

}
