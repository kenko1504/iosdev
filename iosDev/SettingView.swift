//
//  SettingView.swift
//  iosDev
//
//  Created by Kenji Watanabe on 20/4/2025.
//

import SwiftUI

struct SettingView: View {
    @Binding var numberOfBubbles: Double
    @Binding var timeLimit: Double
    var body: some View {
        VStack{
            Text("Time limit: \(Int(timeLimit))")
            Slider(
                value: $timeLimit,
                in: 0...60,
                step: 1
                )
            .padding(.horizontal, 60.0)

            Text("Number of bubbles: \(Int(numberOfBubbles))")
                .padding(.top, 50.0)
            
            Slider(
                value: $numberOfBubbles,
                in: 0...15,
                step: 1
                )
            .padding(.horizontal, 60.0)
        }
        .padding(.top, 100.0)
        Spacer()
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View{
        SettingView(numberOfBubbles: .constant(5), timeLimit: .constant(10))
    }
}
