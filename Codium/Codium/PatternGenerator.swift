//
//  PatternGenerator.swift
//  Codium
//
//  Created by Gilles Zwijsen on 18/10/2023.
//

import Foundation

struct PatternGenerator {
    
    func generatePattern(selectedPattern: String, n: Int) -> String {
           switch selectedPattern {
           case "3.1":
               return pattern3_1(n: n)
           case "3.2":
               return pattern3_2(n: n)
           case "3.3":
               return pattern3_3(n: n)
           case "3.4":
               return pattern3_4(n: n)
           case "3.5":
               return pattern3_5(n: n)
           case "3.6":
               return pattern3_6(n: n)
           default:
               return "Pattern not found"
           }
       }
    
    
    func pattern3_1(n: Int) -> String {
        var output = ""
        for i in 1...n {
            output += String(repeating: "*", count: i) + "\n"
        }
        return output
    }

    func pattern3_2(n: Int) -> String {
        var output = ""
        for i in 1...n {
            output += String(repeating: " ", count: n-i) + String(repeating: "*", count: i) + "\n"
        }
        return output
    }
    func pattern3_3(n: Int) -> String {
        var output = ""

            for i in 1..<n {
                let spaces = String(repeating: " ", count: n - i)
                if i == 1 {
                    output += spaces + "*"
                } else {
                    output += spaces + "*" + String(repeating: " ", count: 2*i-3) + "*"
                }
                output += "\n"
            }
            
            return output
    }

    func pattern3_4(n: Int) -> String {
        var output = ""
        for i in 1...n {
            for j in 1...n {
                if j == i || j == n - i + 1 {
                    output += "*"
                } else {
                    output += " "
                }
            }
            output += "\n"
        }
        return output
        
    }
    func pattern3_5(n: Int) -> String {
        var output = ""

        // Upper
        for i in stride(from: 1, through: n, by: 2) {
            let spaces = String(repeating: " ", count: (n - i) / 2)
            output += spaces + String(repeating: "*", count: i) + "\n"
        }
        
        // Lower
        let lowerStart = n % 2 == 0 ? n - 1 : n - 2
        for i in stride(from: lowerStart, through: 1, by: -2) {
            let spaces = String(repeating: " ", count: (n - i) / 2)
            output += spaces + String(repeating: "*", count: i) + "\n"
        }
        
        return output
    }



    func pattern3_6(n: Int) -> String {
        var output = ""

        // Upper
        for i in 1..<n {
            output += String(repeating: "A", count: n - i)
            output += "+"
            if i > 1 {
                output += String(repeating: "E", count: 2 * i - 3)
                output += "+"
            }
            output += String(repeating: "B", count: n - i)
            output += "\n"
        }

        // Middle
        output += "+"
        if n > 1 {
            output += String(repeating: "E", count: 2 * n - 3)
            output += "+"
        }
        output += "\n"

        // Lower
        for i in (1..<n).reversed() {
            output += String(repeating: "C", count: n - i)
            output += "+"
            if i > 1 {
                output += String(repeating: "E", count: 2 * i - 3)
                output += "+"
            }
            output += String(repeating: "D", count: n - i)
            output += "\n"
        }

        return output
    }




 
}
