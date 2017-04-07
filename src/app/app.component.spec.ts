import { async, TestBed } from '@angular/core/testing';
import { IonicModule } from 'ionic-angular';
import { TwAPIService, GAService } from 'tw-core';
import { MyApp } from './app.component';
import { IonicStorageModule  } from '@ionic/storage';

describe('MyApp Component', () => {
  let fixture;
  let component;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [MyApp],
      imports: [
        IonicModule.forRoot(MyApp)
      ],
      providers: [
          Storage, TwAPIService, GAService
      ]
    })
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MyApp);
    component = fixture.componentInstance;
  });

  it ('should be created', () => {
    expect(component instanceof MyApp).toBe(true);
  });

  it ('should have two pages', () => {
    expect(component.pages.length).toBe(2);
  });

});