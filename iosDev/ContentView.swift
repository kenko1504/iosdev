//
//  ContentView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 15/4/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var userName: String = ""
    @State private var numberOfBubbles: Int = 0
    @State private var timeLimit: Int = 0
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Spacer()
                    NavigationLink(destination: SettingView(settingModel: SettingModel())) {
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
                NavigationLink(destination: GameView(settingModel: SettingModel())) {
                    Text("start game!")
                        .padding()
                }
            }
        }

    }
}

#Preview {
    ContentView()
}
