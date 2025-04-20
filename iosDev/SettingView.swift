//
//  SettingView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 20/4/2025.
//

import SwiftUI

struct SettingView: View {

    @ObservedObject var settingModel: SettingModel
    var body: some View {
        VStack{
            Text("Time limit: \(Int(settingModel.timeLimit))")
            Slider(
                value: $settingModel.timeLimit,
                in: 10...60,
                step: 1
                )
            .padding(.horizontal, 60.0)

            Text("Number of bubbles: \(Int(settingModel.numberOfBubbles))")
                .padding(.top, 50.0)
            
            Slider(
                value: $settingModel.numberOfBubbles,
                in: 5...15,
                step: 1
                )
            .padding(.horizontal, 60.0)
        }
        .padding(.top, 100.0)
        Spacer()
    }
}

#Preview {
    SettingView(settingModel: SettingModel())
}
