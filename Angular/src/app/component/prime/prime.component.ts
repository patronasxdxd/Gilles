import { Component } from '@angular/core';

@Component({
  selector: 'app-prime',
  templateUrl: './prime.component.html',
  styleUrls: ['./prime.component.css']
})
export class PrimeComponent {
  public primes: number[] = [];
  public number: number = 100;  // Default number up to which primes are generated
  errorMessage: string = '';

  constructor() {}

  isPrime(num: number): boolean {
    if (num <= 1) return false;
    if (num <= 3) return true;

    if (num % 2 === 0 || num % 3 === 0) return false;

    let i = 5;
    while (i * i <= num) {
      if (num % i === 0 || num % (i + 2) === 0) return false;
      i += 6;
    }

    return true;
  }

  filterNumber(): void {
    const originalValue = this.number;
    this.number = parseInt(this.number.toString(), 10);
    
    this.primes = [];

    if (isNaN(this.number)) {
        this.errorMessage = 'Please enter a valid number.';
        this.number = originalValue; // reset to original value
    } else {
        this.errorMessage = '';
    }
  }

  generatePrimes(): void {
    this.primes = [];
    if(!isNaN(this.number)) {
      for (let i = 2; i <= this.number; i++) {
        if (this.isPrime(i)) {
          this.primes.push(i);
        }
      }
    }
  }
}
