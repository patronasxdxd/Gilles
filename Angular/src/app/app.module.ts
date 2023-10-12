import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http'
import { RouterModule } from '@angular/router';

import { AppComponent } from './app.component';
import { TodoComponent } from './component/todo/todo.component';
import { AppRoutingModule } from './app-routing.module';
import { NavbarComponent } from './component/navbar/navbar.component';
import { PrimeComponent } from './component/prime/prime.component';
import { OutputComponent } from './component/output/output.component';
import { LeapYearComponent } from './component/leap-year/leap-year.component';
import { FizzbuzComponent } from './component/fizzbuz/fizzbuz.component';

@NgModule({
  declarations: [
    AppComponent,
    TodoComponent,
    NavbarComponent,
    PrimeComponent,
    OutputComponent,
    LeapYearComponent,
    FizzbuzComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
