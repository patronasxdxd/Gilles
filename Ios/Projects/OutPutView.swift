//
//  OutputView.swift
//  Projects
//
//  Created by Gilles Zwijsen on 11/10/2023.
//
import SwiftUI

struct OutputView: View {
    @State private var n = 9
    
    var body: some View {
        VStack {
            Form {
                Picker("Select n", selection: $n) {
                    ForEach(1..<11) { number in
                        Text("\(number)").tag(number)
                    }
                }
            }
            .padding(.bottom, 20)
            .padding(.top, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(patternOutput(selectedPattern: "3.1", n: n))
                        .modifier(PatternTextModifier())
                    
                    Text(patternOutput(selectedPattern: "3.2", n: n))
                        .modifier(PatternTextModifier())
                    
                    Text(patternOutput(selectedPattern: "3.3", n: n))
                        .modifier(PatternTextModifier())
                    
                    Text(patternOutput(selectedPattern: "3.4", n: n))
                        .modifier(PatternTextModifier())
                    
                    Text(patternOutput(selectedPattern: "3.5", n: n))
                        .modifier(PatternTextModifier())
                    
                    Text(patternOutput(selectedPattern: "3.6", n: n))
                        .modifier(PatternTextModifier())
                }
            }
        }
        .navigationTitle("Pattern Generator")
    }
}

struct PatternTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.body, design: .monospaced))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
}

struct OutputView_Previews: PreviewProvider {
    static var previews: some View {
        OutputView()
    }
}
