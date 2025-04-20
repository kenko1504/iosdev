//
//  gameView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 18/4/2025.
//

import SwiftUI

struct Bubble: Identifiable, Equatable {
    let id = UUID()
    var position: CGPoint
    var color: Color
    let size: CGFloat = 60
}

struct GameView: View {
    @State private var score: Int = 0
    @State private var localTimeLimit: Double = 10
    @State private var timerRunning: Bool = true
    @State private var bubbles: [Bubble] = []

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @Binding var timeLimit: Double

    // Screen size placeholder
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let bubbleCount = 10
    let bubbleColors: [Color] = [.red, .blue, .green, .yellow, .purple]

    var body: some View {
        ZStack {
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
            }

            ForEach(bubbles) { bubble in
                Circle()
                    .fill(bubble.color)
                    .frame(width: bubble.size, height: bubble.size)
                    .position(bubble.position)
                    .onTapGesture {
                        score += 1
                        bubbles.removeAll { $0 == bubble }
                    }
            }
        }
        .onAppear {
            localTimeLimit = timeLimit
            generateNonOverlappingBubbles()
        }
    }

    func generateNonOverlappingBubbles() {
        var newBubbles: [Bubble] = []

        while newBubbles.count < bubbleCount {
            let radius: CGFloat = 30
            let newX = CGFloat.random(in: radius...(screenWidth - radius))
            let newY = CGFloat.random(in: 100...(screenHeight - radius - 50)) // avoid top bar

            let newPosition = CGPoint(x: newX, y: newY)

            let newBubble = Bubble(position: newPosition, color: bubbleColors.randomElement()!)

            let overlaps = newBubbles.contains { existing in
                let dx = existing.position.x - newBubble.position.x
                let dy = existing.position.y - newBubble.position.y
                let distance = sqrt(dx * dx + dy * dy)
                return distance < existing.size
            }

            if !overlaps {
                newBubbles.append(newBubble)
            }
        }

        self.bubbles = newBubbles
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(timeLimit: .constant(10))
    }
}
