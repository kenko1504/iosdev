//
//  gameView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 18/4/2025.
//  This code is so spaghetti


import SwiftUI

struct Bubble: Identifiable, Equatable {
    let id = UUID()
    var position: CGPoint
    var color: Color
    let size: CGFloat = 60
    var initialAppearance: Bool = false
}

struct GameView: View {
    @State private var highScore: Int = 0
    @State private var score: Int = 0
    @State private var localUserName: String = ""
    @State private var localTimeLimit: Double = 60
    @State private var localPlayers: [(name:String, score:Int)] = []
    @State private var localScore: Int = 0
    @State private var timerRunning: Bool = true
    @State private var bubbles: [Bubble] = []
    //boolean state to programmatically change to game over view when time limit reaches zero.
    @State private var transitionToGameOverView: Bool = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @Binding var timeLimit: Double
    @Binding var numberOfBubbles: Double
    @Binding var userName: String
    @Binding var players: [(name:String, score:Int)]

    // Screen size placeholder
    // -50 offset to ensure bubble fully appears in the game window NEED FIX
    let screenWidth = UIScreen.main.bounds.width - 50
    let screenHeight = UIScreen.main.bounds.height - 50
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

        NavigationView{
            ZStack {
                VStack {
                    HStack {
                        Text("Time: \(Int(localTimeLimit))")
                            .onAppear{
                                
                                // this code is called to reset timer user re enters this view from its child
                                // it also runs the first time when this view is entered
                                transitionToGameOverView = false
                                timerRunning = true
                                localScore = 0
                                localUserName = userName
                                highScore = obtainHighScore()
                            }
                            //the code is executed every second.
                            .onReceive(timer) { _ in
//                                print(players)
                                localScore = score
                                if localTimeLimit > 0 && timerRunning {
                                    localTimeLimit -= 1
                                    //TASK:randomly remove bubbles
                                    //1.generate a random number x
                                    deleteRandomBubbles()
                                    //generate random number y; however y + current existing bubble count must now exceed the limit
                                    //add y new bubble that does not overlap
                                    
                                    //randomly add newly positioned bubbles
                                    regenerateRandomBubbles()
                                }
                                else {
                                    timerRunning = false
                                    if (transitionToGameOverView == false){
                                        players.append((localUserName, localScore))
                                        localPlayers = players
                                    }
                                    transitionToGameOverView = true
                                }
                                
                            }
                        Spacer()
                        NavigationLink(destination: GameOverView(localPlayers:$localPlayers), isActive: $transitionToGameOverView){
                        }
                        Text("Score: \(score)")
                        Spacer()
                        Text("High score: \(highScore)")
                    }
                    .padding(.horizontal, 20.0)
                    
                    Spacer()
                }
                //render the actual bubble each frame;
                ForEach(bubbles) { bubble in
                    Circle()
                        .fill(bubble.color)
                        .frame(width: bubble.size, height: bubble.size)
                        .position(bubble.position)
                        .opacity(bubble.initialAppearance ? 1:0)
                        .onAppear{
                            // add fade in effect for the first ever appeared bubbles
                            withAnimation(.easeIn(duration:1.0)){
                                if let index = bubbles.firstIndex(where: {$0.id == bubble.id}){
                                    bubbles[index].initialAppearance = true
                                }
                            }
                            //move bubble outside the screen
                            withAnimation(.easeIn(duration:2).delay(1)){
                                if let index = bubbles.firstIndex(where: {$0.id == bubble.id}){
                                    //generate a random target coordinate outside the screen
                                    //generate 8 coordinates that the bubble will travel towards ousdie the screen
                                    let screenBounds = UIScreen.main.bounds
                                    let destinations: [(CGFloat, CGFloat)] = [
                                        (-100, -100), // Top-left, outside screen
                                        (screenBounds.width + 100, -100), // Top-right, outside screen
                                        (screenBounds.width/2, -100), // Top-mid
                                        (screenBounds.width/2, screenBounds.height+100), // Bottom-mid
                                        (-100, screenBounds.height + 100), // Bottom-left, outside screen
                                        (-100, screenBounds.height/2), //left mid
                                        (screenBounds.width/2 + 100, screenBounds.height), //right mid
                                        (screenBounds.width + 100, screenBounds.height + 100) // Bottom-right, outside screen
                                    ]
                                    
                                    // Select a random destination
                                    if let result = destinations.randomElement() {
                                        // Update position with CGFloat values
                                        bubbles[index].position = CGPoint(x: result.0, y: result.1)
                                    }
                                }
                            }
                        }
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
                            //tapped bubble gets removed
                            bubbles.removeAll { $0 == bubble }
                            
                            updateHighScoreRealTime()
                        }
                }
            }
            .onAppear {
                localTimeLimit = timeLimit

                
                //the attributes for bubbles are generated once when this view is first accessed
                initialGenerateNonOverlappingBubbles()
            }

        }
    }
    
    func deleteRandomBubbles(){
        //remove random bubbles
        let maxRemoval = numberOfBubbles/2
        let randomRemovalNumber = Int.random(in: 1...Int(maxRemoval))
        let indicesToRemove = Array(bubbles.indices.shuffled().prefix(randomRemovalNumber))
        
        for index in indicesToRemove.sorted(by: >) {
            bubbles.remove(at: index)
        }
    }
    
    func regenerateRandomBubbles(){
        //get the current bubble count
        let bCount = bubbles.count
        
        //do not regenerate when there are max number of bubble (the limit in the settings)
        if (bCount == Int(numberOfBubbles)){
            return
        }
        //must not generate more bubbles then the number limit in the settings
        let randomGenerationNumber = Int.random(in: 1...(Int(numberOfBubbles)-bCount))
        
        for _ in 0..<randomGenerationNumber {
            let radius: CGFloat = 30
            let newX = CGFloat.random(in: radius...(screenWidth - radius))
            let newY = CGFloat.random(in: 100...(screenHeight - radius - 50)) // avoid top bar

            let newPosition = CGPoint(x: newX, y: newY)
            
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
            
            //create new bubble
            let newBubble = Bubble(position: newPosition, color: colorPool.randomElement()!)

            let overlaps = bubbles.contains { existing in
                let dx = existing.position.x - newBubble.position.x
                let dy = existing.position.y - newBubble.position.y
                let distance = sqrt(dx * dx + dy * dy)
                return distance < existing.size
            }

            if !overlaps {
                bubbles.append(newBubble)
            }
            else{
                continue
            }
        }
        
    }
    
    func updateHighScoreRealTime()-> Void{
        if (score > obtainHighScore()){
            highScore = score
        }
    }
    
    func obtainHighScore()-> Int{
        //find the highest score by accessing the 2nd pair of the tuple element
        //add player score data from tuple into an array for int only
        //use max() to find highest score
        print(players)
        var scoreArr:[Int] = []
        for playerTuple in players {
            scoreArr.append(playerTuple.1)
        }
        print(scoreArr)
        print(scoreArr.max())
        return scoreArr.max() ?? 0
    }
    
    func initialGenerateNonOverlappingBubbles() {
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
        GameView(timeLimit: .constant(60), numberOfBubbles: .constant(15), userName: .constant(""), players: . constant([]))
    }
}
