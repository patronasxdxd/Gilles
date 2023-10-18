import SwiftUI

struct ContentView: View {
    enum ActiveView {
        case fizzBuzz
        case leapYear
        case output
        case prime
        case todo
        case none
    }

    @State private var activeView: ActiveView = .none
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(spacing: 10) {
                Button("FizzBuzz") {
                    activeView = .fizzBuzz
                }
                .buttonStyle(GrowingButtonStyle())

                Button("Leap Year") {
                    activeView = .leapYear
                }
                .buttonStyle(GrowingButtonStyle())
                Button("TODO") {
                    activeView = .todo
                }
                .buttonStyle(GrowingButtonStyle())
                Button("PRIME") {
                    activeView = .prime
                }
                .buttonStyle(GrowingButtonStyle())
                
                Button("Output") {
                    activeView = .output
                }
                .buttonStyle(GrowingButtonStyle())
            }
            .padding()
            
            Spacer()
            
            
            switch activeView {
            case .fizzBuzz:
                FizzBuzzView()
            case .leapYear:
                LeapYearView()
            case .output:
                OutputView()
            case .todo:
                TODOView()
            case .prime:
                PrimeView()
            case .none:
                WelcomeView()
            }
        }
        .navigationTitle("Assignments")
    }
}

struct GrowingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.blue.opacity(0.7) : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
