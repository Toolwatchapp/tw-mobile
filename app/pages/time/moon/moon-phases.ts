import { Component, OnInit, ElementRef } from '@angular/core';
import { Astro } from 'tw-common/dist/app/directives/clock/astro';

@Component({
  selector: 'moon-phases',
  templateUrl: 'build/pages/time/moon/moon-phases.html'
})
export class MoonPhases extends Astro implements OnInit {
  
  constructor(private elementRef: ElementRef) {
  	super();

    let d = new Date();
    d.setUTCHours(23);

    // Waiting https://github.com/slowe/astro.js/issues/1
  	// this.illum = this.getMoonIllumination(d);
  	// this.pos = this.getMoonPosition(d, 0, 0);
  	// this.angleMoon = this.illum.angle - this.pos.parallacticAngle;
    this.angleMoon =  this.getMoonPhase();
  }

  private getMoonPhase()
  {

    let theDate = new Date();
    let phasePercent = this.moonPhasePercent(theDate);
    let thePhase = Math.round(phasePercent * 0.279);

    return thePhase;
  }

  private moonPhasePercent(theDate:Date):number
  {
    let synodic = 29.53058867;
    let msPerDay = 86400000;
    let baseDate:Date = new Date();
    baseDate.setUTCFullYear(2005);
    baseDate.setUTCMonth(4);
    baseDate.setUTCDate(8);
    baseDate.setUTCHours(8);
    baseDate.setUTCMinutes(48);

    let diff:number = theDate.getMilliseconds() - baseDate.getMilliseconds();
    let phase = diff / (synodic * msPerDay);
    phase *= 100;
    phase %= 100;
    if ( phase < 0 )
      phase += 100;

    return(phase);
  }

  ngAfterViewInit() {
  	let elem = this.elementRef.nativeElement.querySelector('.moon-disque')
  	elem.style.webkitTransform = 'rotateZ(' + this.angleMoon*360*0.29 + 'deg)';
  	elem.style.transform = 'rotateZ(' + this.angleMoon*360*0.29 + 'deg)';
  }

  ngOnInit() {
  }
}
