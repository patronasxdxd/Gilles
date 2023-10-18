//
//  LeapYearView.swift
//  Projects
//
//  Created by Gilles Zwijsen on 11/10/2023.
//

import SwiftUI

struct LeapYearView: View {
    @State private var year: String = ""
    @State private var isLeapYear: Bool? = nil

    var body: some View {
        LeapYearInputView(year: $year, isLeapYear: $isLeapYear)
            .navigationTitle("Leap Year")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.red.opacity(0.3))
    }
}
