import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FizzbuzComponent } from './fizzbuz.component';

describe('FizzbuzComponent', () => {
  let component: FizzbuzComponent;
  let fixture: ComponentFixture<FizzbuzComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [FizzbuzComponent]
    });
    fixture = TestBed.createComponent(FizzbuzComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
