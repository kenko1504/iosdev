//
//  gameView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 18/4/2025.
//

import SwiftUI

struct GameView: View {
    //receives the binded data "timeLimit" from content view
    @Binding var timeLimit: Double
    var body: some View {
        VStack{
            HStack{
                Text("Time: \(Int(timeLimit))")
            }
            Spacer()
            
        }

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View{
        GameView(timeLimit: .constant(10))
    }
}
