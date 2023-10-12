import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { TodoComponent } from './component/todo/todo.component';
import { Routes } from '@angular/router';
import { LeapYearComponent } from './component/leap-year/leap-year.component';
import { OutputComponent } from './component/output/output.component';
import { PrimeComponent } from './component/prime/prime.component';
import { FizzbuzComponent } from './component/fizzbuz/fizzbuz.component';

const routes: Routes = [
  { path: '', component: OutputComponent },
  { path: 'fizzbuzz', component: FizzbuzComponent },
  { path: 'todo', component: TodoComponent },
  { path: 'leapyear', component: LeapYearComponent },
  { path: 'prime', component: PrimeComponent },
  { path: 'output', component: OutputComponent }
];


@NgModule({
  
  declarations: [],
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
