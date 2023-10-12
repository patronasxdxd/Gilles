import { Component } from '@angular/core';

@Component({
  selector: 'app-leap-year',
  templateUrl: './leap-year.component.html',
  styleUrls: ['./leap-year.component.css']
})
export class LeapYearComponent {
  year: string = '';
  displayedYear: string = '';
  errorMessage: string = '';

  isLeapYear: boolean | null = null;

  checkLeapYear(): void {
    const yr = parseInt(this.year, 10);
    if (isNaN(yr)) {
        this.errorMessage = 'Please enter a valid number.';
        this.isLeapYear = null; // Resets the leap year status
    } else {
        this.isLeapYear = this.isLeap(yr);
        this.displayedYear = this.year;
        this.errorMessage = ''; // Clears the error message if no error
    }
  }

  isLeapYearMessage(): string {
    if (this.isLeapYear === null) return '';
    return this.isLeapYear ? `${this.displayedYear} is a leap year` : `${this.displayedYear} is not a leap year`;
  }

  private isLeap(year: number): boolean {
    return (year % 400 === 0) || (year % 100 !== 0 && year % 4 === 0);
  }
}
