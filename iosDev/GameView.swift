//
//  gameView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 18/4/2025.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var settingModel: SettingModel
    var body: some View {
        VStack{
            HStack{
                Text("Time: \(Int(settingModel.timeLimit))")
            }
            Spacer()
            
        }

    }
}

#Preview {
    GameView(settingModel: SettingModel())
}
