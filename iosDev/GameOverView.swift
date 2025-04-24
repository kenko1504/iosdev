//
//  gameoverView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 22/4/2025.
//

import SwiftUI

// Force to enter this view after time reach zero in game view
struct GameOverView: View {
    @State var testPlayers = [("Bob", 10), ("Alice", 4), ("Tran", 76), ("Bob", 34)]
    @Binding var localPlayers: [(name:String, score: Int)]
    var body: some View {

        Text("Score Board")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .onAppear{
//                print(localPlayers), debugging for real time array behaviour in the console
                //sort the local players array so it displays the highest point player into lowest in descending order.
                localPlayers = localPlayers.sorted
                {
                        $0.1 > $1.1
                }

            }
        Spacer()
        //displays the array in list view. Each addition of tuple element in array increases the row within the list
        List(localPlayers.indices, id: \.self) { data in
            let tuple = localPlayers[data]
            HStack {
                Text(tuple.0)
                Spacer()
                Text("\(tuple.1)")
            }
        }
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    GameOverView(localPlayers: .constant([]))
}
