//
//  SettingView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 20/4/2025.
//

import SwiftUI

struct SettingView: View {
    @State private var timeLimit: Double = 10
    @State private var numberOfBubbles: Double = 5
    var body: some View {
        VStack{
            Text("Time limit: \(Int(timeLimit))")
            Slider(
                value: $timeLimit,
                in: 10...60,
                step: 1
                )
            .padding(.horizontal, 60.0)

            Text("Number of bubbles: \(Int(numberOfBubbles))")
                .padding(.top, 50.0)
            
            Slider(
                value: $numberOfBubbles,
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
    SettingView()
}
