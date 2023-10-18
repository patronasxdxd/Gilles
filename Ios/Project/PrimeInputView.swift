//
//  PrimeInputView.swift
//  Projects
//
//  Created by Gilles Zwijsen on 11/10/2023.
//

import SwiftUI

struct PrimeInputView: View {
    @Binding var number: String
    @Binding var primes: [Int]

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter a number", text: $number)
                           .onChange(of: number) { newValue in
                               let filtered = newValue.filter { "0123456789".contains($0) }
                               if filtered != newValue {
                                   self.number = filtered
                               }
                           }
                           .padding()
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                

            Button("Find Primes") {
                if let n = Int(number) {
                    primes = findPrimes(upTo: n)
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding()
    }
}

struct PrimeInputView_Previews: PreviewProvider {
    static var previews: some View {
        PrimeInputView(number: .constant(""), primes: .constant([]))
    }
}
