//
//  ContentView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 15/4/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var userName: String = ""
    var body: some View {
        NavigationView{
            VStack{
                Text("Bubble Pop")
                    .bold()
                TextField("Enter your name:",
                          text:$userName)
                NavigationLink(destination: gameView()) {
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
