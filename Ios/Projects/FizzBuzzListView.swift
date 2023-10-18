//
//  FizzBuzzListView.swift
//  Projects
//
//  Created by Gilles Zwijsen on 11/10/2023.
//
import SwiftUI

struct FizzBuzzListView: View {
    var body: some View {
        List {
            ForEach(1..<101) { number in
                Text(fizzBuzz(number: number))
            }
        }
    }
}
