import { Component } from '@angular/core';

@Component({
  selector: 'app-output',
  templateUrl: './output.component.html',
  styleUrls: ['./output.component.css']
})
export class OutputComponent {

selectedPattern: string = '3.6';
  selectedNumber: number = 20;
  numberOptions: number[] = Array.from({length: 20}, (_, i) => i + 1);
  patternDisplay: string[] = [];

  constructor() { }

  ngOnInit(): void {
    this.updatePatternDisplay();
  }

  onPatternChange(): void {
    this.updatePatternDisplay();
  }

  updatePatternDisplay(): void {
    const pattern = this.patternOutput(this.selectedPattern, this.selectedNumber);
    this.patternDisplay = pattern.split('\n').filter(line => line.trim() !== ''); // This will remove any empty lines
}


  pattern3_1(n: number): string {
    let output = "";
    for (let i = 1; i <= n; i++) {
        output += "*".repeat(i) + "\n";
    }
    return output;
  }

  pattern3_2(n: number): string {
    let output = "";
    for (let i = 1; i <= n; i++) {
        output += " ".repeat(n-i) + "*".repeat(i) + "\n";
    }
    return output;
  }

  pattern3_3(n: number): string {
    let output = "";
    for (let i = 1; i < n; i++) {
        let spaces = " ".repeat(n - i);
        if (i == 1) {
            output += spaces + "*";
        } else {
            output += spaces + "*" + " ".repeat(2*i-3) + "*";
        }
        output += "\n";
    }
    return output;
  }

  pattern3_4(n: number): string {
    let output = "";
    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= n; j++) {
            if (j == i || j == n - i + 1) {
                output += "*";
            } else {
                output += " ";
            }
        }
        output += "\n";
    }
    return output;
  }

  pattern3_5(n: number): string {
    let output = "";

    // Upper
    for (let i = 1; i <= n; i += 2) {
        let spaces = " ".repeat((n - i) / 2);
        output += spaces + "*".repeat(i) + "\n";
    }
    
    // Lower
    let lowerStart = n % 2 == 0 ? n - 1 : n - 2;
    for (let i = lowerStart; i >= 1; i -= 2) {
        let spaces = " ".repeat((n - i) / 2);
        output += spaces + "*".repeat(i) + "\n";
    }
    
    return output;
  }

  pattern3_6(n: number): string {
    let output = "";

    // Upper
    for (let i = 1; i < n; i++) {
        output += "A".repeat(n - i) + "+";
        if (i > 1) {
            output += "E".repeat(2 * i - 3) + "+";
        }
        output += "B".repeat(n - i) + "\n";
    }

    // Middle
    output += "+";
    if (n > 1) {
        output += "E".repeat(2 * n - 3) + "+";
    }
    output += "\n";

    // Lower
    for (let i = n - 1; i >= 1; i--) {
        output += "C".repeat(n - i) + "+";
        if (i > 1) {
            output += "E".repeat(2 * i - 3) + "+";
        }
        output += "D".repeat(n - i) + "\n";
    }

    return output;
  }

  patternOutput(selectedPattern: string, n: number): string {
    switch (selectedPattern) {
        case "3.1":
            return this.pattern3_1(n);
        case "3.2":
            return this.pattern3_2(n);
        case "3.3":
            return this.pattern3_3(n);
        case "3.4":
            return this.pattern3_4(n);
        case "3.5":
            return this.pattern3_5(n);
        case "3.6":
            return this.pattern3_6(n);
        default:
            return "Pattern not found";
    }
  }
}