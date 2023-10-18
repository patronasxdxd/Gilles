//
//  PrimeView.swift
//  Projects
//
//  Created by Gilles Zwijsen on 11/10/2023.
//

import SwiftUI

struct PrimeView: View {
    @State private var number: String = ""
    @State private var primes: [Int] = []
    
    var body: some View {
        VStack {
            PrimeInputView(number: $number, primes: $primes)
                .navigationTitle("Prime Number Finder")
            
            Text("Primes: \(primes.map { String($0) }.joined(separator: ", "))")
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red.opacity(0.3))
    }
}

struct PrimeView_Previews: PreviewProvider {
    static var previews: some View {
        PrimeView()
    }
}



