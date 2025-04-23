//
//  gameoverView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 22/4/2025.
//

import SwiftUI

// Force to enter this view after time reach zero in game view
// User can either enter contentview or game view from this view
struct GameOverView: View {
    @Binding var localPlayers: [(name:String, score: Int)]
    var body: some View {

        Text("Score Board")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .onAppear{
            }
        Spacer()
        List(localPlayers, id: \.0) { localPlayers in
            HStack {
                Text(localPlayers.0)
                Spacer()
                Text("\(localPlayers.1)")
            }
        }
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    GameOverView(localPlayers: .constant([]))
}
