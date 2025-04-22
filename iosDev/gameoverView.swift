//
//  gameoverView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 22/4/2025.
//

import SwiftUI

struct gameoverView: View {
    @State var players: [(name:String, score:Int)] = [(name:"Tim", score:200), (name:"Tony", score:56), ("me", 298)]

    var body: some View {
        Text("Score Board")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        Spacer()
        List(players, id: \.0) { player in
            HStack {
                Text(player.0)
                Spacer()
                Text("\(player.1)")
            }
        }
    }
}

#Preview {
    gameoverView()
}
