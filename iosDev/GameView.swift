//
//  gameView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 18/4/2025.
//

import SwiftUI

struct GameView: View {
    //seems like @State must be called first before @Binding to avoid unintended behaviour
    @State private var score: Int = 0
    //receives the binded data "timeLimit" from content view
    @Binding var timeLimit: Double

    var body: some View {
        VStack{
            HStack{
                Text("Time: \(Int(timeLimit))")
                Spacer()
                Text("Score: \(Int(score))")
            }
            .padding(.horizontal, 20.0)
            Spacer()
            Button("test"){
            }
        }

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View{
        GameView(timeLimit: .constant(10))
    }
}
