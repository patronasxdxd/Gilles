//
//  FizzBuzzView.swift
//  Projects
//
//  Created by Gilles Zwijsen on 11/10/2023.
//

// FizzBuzzView.swift
import SwiftUI

struct FizzBuzzView: View {
    var body: some View {
        FizzBuzzListView()
            .navigationTitle("FizzBuzz")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.red.opacity(0.3))
    }
    
}
