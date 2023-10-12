import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-fizzbuz',
  templateUrl: './fizzbuz.component.html',
  styleUrls: ['./fizzbuz.component.css']
})
export class FizzbuzComponent implements OnInit{
  numbers: {text: string, class: string}[] = [];

  constructor() { }

  ngOnInit(): void {
    for (let i = 1; i <= 100; i++) {
      this.numbers.push(this.fizzBuzz(i));
    }
  }

  fizzBuzz(number: number): {text: string, class: string} {
    if (number % 3 === 0 && number % 5 === 0) return {text: 'FizzBuzz', class: 'fizzbuzz'};
    if (number % 3 === 0) return {text: 'Fizz', class: 'fizz'};
    if (number % 5 === 0) return {text: 'Buzz', class: 'buzz'};
    return {text: number.toString(), class: 'number'};
  }
  
}
