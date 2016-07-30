import {Component, forwardRef} from '@angular/core';
import {Nav, Loading, NavController, NavParams} from 'ionic-angular';
import {TwAPIService} from 'tw-common/dist/app/services/twapi.service';
import {BlogPost} from 'tw-common/dist/app/models/blog-post.model';
import {TRANSLATE_PROVIDERS, TranslateService, TranslatePipe, TranslateLoader, TranslateStaticLoader} from 'ng2-translate/ng2-translate';
import { HTTP_PROVIDERS }  from '@angular/http';
import {Header}  from '../header/header';
import {Footer} from '../footer/footer';
import {GAService} from 'tw-common/dist/app/services/ga.service';
import { Wove } from 'aspect.js/dist/lib/aspect';

@Wove()
@Component({
	templateUrl: 'build/pages/tips/tips.html',
	pipes: [TranslatePipe],
	directives: [forwardRef(() => Footer), Header]
})
export class TipsPage {

	user:any;
	posts:BlogPost[];
	laoding:Loading = Loading.create();
	

	constructor(private nav: NavController, private navParams: NavParams,
		private twapi: TwAPIService, private translate: TranslateService) {

		this.user = this.navParams.get('user');
    	GAService.screenview("TIPS");


		this.twapi.getBlogPosts().then(
			posts => {
				this.posts = posts;
				this.laoding.dismiss();
			}
		);
	}

	ngAfterViewInit() {

		this.nav.present(this.laoding);
	}


}
