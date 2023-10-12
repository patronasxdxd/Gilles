import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LeapYearComponent } from './leap-year.component';

describe('LeapYearComponent', () => {
  let component: LeapYearComponent;
  let fixture: ComponentFixture<LeapYearComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [LeapYearComponent]
    });
    fixture = TestBed.createComponent(LeapYearComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
