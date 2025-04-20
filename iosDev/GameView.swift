//
//  gameView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 18/4/2025.
//

import SwiftUI
struct GameView: View {
    @State private var score: Int = 0
    @State private var localTimeLimit: Double = 0
    @State private var timerRunning: Bool = true

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    // This will only be used to get the initial value
    @Binding var timeLimit: Double

    var body: some View {
        VStack {
            HStack {
                Text("Time: \(Int(localTimeLimit))")
                    .onReceive(timer) { _ in
                        if localTimeLimit > 0 && timerRunning {
                            localTimeLimit -= 1
                        } else {
                            timerRunning = false
                        }
                    }
                Spacer()
                Text("Score: \(score)")
            }
            .padding(.horizontal, 20.0)

            Spacer()

            Button("Test") {
                // Test logic
            }
        }
        .onAppear {
            localTimeLimit = timeLimit // Copy once on appear
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(timeLimit: .constant(10))
    }
}
