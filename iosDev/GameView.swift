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
    @Binding var numberOfBubbles: Double

    // Screen size placeholder
    // -20 offset to ensure bubble fully appears in the game window
    let screenWidth = UIScreen.main.bounds.width - 20
    let screenHeight = UIScreen.main.bounds.height - 20
    let bubbleColors: [Color] = [.red, .pink, .green, .blue, .black]
    
    // track previous bubble color tapped; initialy color is brown to prevent extra points from consecutive color. this will be replaced in game
    @State var previousTappedBubble: Color = .brown // must be declared as @State to be mutable
    let consecutiveMultiplier: Double = 1.5
    
    let redPoints: Double = 1
    let pinkPoints: Double = 2
    let greenPoints: Double = 5
    let bluePoints: Double = 8
    let blackPoints: Double = 10

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
                //when user taps bubble
                    .onTapGesture {
                        if (bubble.color == .red){
                            if (previousTappedBubble == .red){
                                score += Int(round(redPoints*consecutiveMultiplier))
                            }
                            else{
                                score += Int(redPoints)
                            }
                            previousTappedBubble = .red
                        }
                        else if (bubble.color == .pink){
                            if (previousTappedBubble == .pink){
                                score += Int(round(pinkPoints*consecutiveMultiplier))
                            }
                            else{
                                score += Int(pinkPoints)
                            }
                            previousTappedBubble = .pink
                        }
                        else if (bubble.color == .green){
                            if (previousTappedBubble == .green){
                                score += Int(round(greenPoints*consecutiveMultiplier))
                            }
                            else{
                                score += Int(greenPoints)
                            }
                            previousTappedBubble = .green
                        }
                        else if (bubble.color == .blue){
                            if (previousTappedBubble == .blue){
                                score += Int(round(bluePoints*consecutiveMultiplier))
                            }
                            else{
                                score += Int(bluePoints)
                            }
                            previousTappedBubble = .blue
                        }
                        else if (bubble.color == .black){
                            if (previousTappedBubble == .black){
                                score += Int(round(blackPoints*consecutiveMultiplier))
                            }
                            else{
                                score += Int(blackPoints)
                            }
                            previousTappedBubble = .black
                        }
                        bubbles.removeAll { $0 == bubble }
                    }
            }
        }
        .onAppear {
            localTimeLimit = timeLimit
            
            //the attributes for bubbles are generated once when this view is first accessed
            generateNonOverlappingBubbles()
        }
    }

    func generateNonOverlappingBubbles() {
        var newBubbles: [Bubble] = []
        
        // appearance probability
        let weightedColors: [(Color, Int)] = [
            (.red, 40),
            (.pink, 30),
            (.green, 15),
            (.blue, 10),
            (.black, 5)
        ]
        
        //generate an array containing 100 bubble colors with the correct amount of colors as indicated in the weightedColor variable
        let colorPool = weightedColors.flatMap {
            color, weight in Array(repeating: color, count: weight)
        }
        
        while newBubbles.count < Int(numberOfBubbles) {
            let radius: CGFloat = 30
            let newX = CGFloat.random(in: radius...(screenWidth - radius))
            let newY = CGFloat.random(in: 100...(screenHeight - radius - 50)) // avoid top bar

            let newPosition = CGPoint(x: newX, y: newY)
            
            //create new bubble
            let newBubble = Bubble(position: newPosition, color: colorPool.randomElement()!)

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
        GameView(timeLimit: .constant(60), numberOfBubbles: .constant(15))
    }
}
