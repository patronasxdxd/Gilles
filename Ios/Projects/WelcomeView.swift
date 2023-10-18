//
//  WelcomeView.swift
//  Projects
//
//  Created by Gilles Zwijsen on 11/10/2023.
//

import SwiftUI

struct WelcomeView: View {

    var body: some View {
       Text("welcome")
            .navigationTitle("Leap Year")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.red.opacity(0.3))
    }
}
