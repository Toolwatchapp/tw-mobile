import { Component, OnInit, ElementRef } from '@angular/core';
import { Astro } from 'tw-common/dist/app/directives/clock/astro';

@Component({
  selector: 'moon-phases',
  templateUrl: 'build/pages/time/moon/moon-phases.html'
})
export class MoonPhases extends Astro implements OnInit {
  
  constructor(private elementRef: ElementRef) {
  	super();
	this.illum = this.getMoonIllumination(new Date());
	this.pos = this.getMoonPosition(new Date(), 0, 0);
	this.angleMoon = this.illum.angle - this.pos.parallacticAngle;
	console.log(this.illum.angle-this.pos.parallacticAngle);
	console.log();
  }

  ngAfterViewInit() {
	let elem = this.elementRef.nativeElement.querySelector('.moon-disque')
	elem.style.webkitTransform = 'rotateZ(' + this.angleMoon*360 + 'deg)';
	elem.style.transform = 'rotateZ(' + this.angleMoon*360 + 'deg)';
  }

  ngOnInit() {
  }
}
