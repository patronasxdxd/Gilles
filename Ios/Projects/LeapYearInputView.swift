//
//  LeapYearInputView.swift
//  Projects
//
//  Created by Gilles Zwijsen on 11/10/2023.
//

import SwiftUI

struct LeapYearInputView: View {
    @Binding var year: String
    @Binding var isLeapYear: Bool?

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter a year", text: $year)
                .onChange(of: year) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.year = filtered
                    }
                }
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if let isLeap = isLeapYear {
                Text(isLeap ? "\(year) is a leap year" : "\(year) is not a leap year")
            }

            Button("Check") {
                if let yr = Int(year) {
                    isLeapYear = isLeap(year: yr)
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
