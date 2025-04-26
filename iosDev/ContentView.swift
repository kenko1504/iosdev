//
//  ContentView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 15/4/2025.
// test2
//new line

import SwiftUI

struct ContentView: View {
    @State private var userName: String = ""
    @State private var numberOfBubbles: Double = 15
    @State private var timeLimit: Double = 60
    @State private var players: [(name:String, score:Int)] = []
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Spacer()
                    //bind the no of bubbles and timeLimit to settings view
                    NavigationLink(destination:
                                    SettingView(numberOfBubbles:$numberOfBubbles, timeLimit:$timeLimit)) {
                        Text("Setting")
                            .padding(.horizontal)
                    }
                        
                }
                Text("Bubble Pop")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .bold()
                    
                    
                    
                Spacer()
                TextField("Enter your name:",
                          text:$userName)
                .multilineTextAlignment(.center)
                Divider()
                    .padding(/*@START_MENU_TOKEN@*/.horizontal, 60.0/*@END_MENU_TOKEN@*/)
                
                
                Spacer()
                NavigationLink(destination: GameView(timeLimit:$timeLimit, numberOfBubbles:$numberOfBubbles, userName:$userName, players:$players)) {
                    Text("start game!")
                        .padding()
                }
                
            }
            .onAppear{
            }
        }
    }
}

#Preview {
    ContentView()
}
