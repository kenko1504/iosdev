//
//  settingModel.swift
//  iosDev
//
//  Created by Kenji Watanabe on 18/4/2025.
//

import Foundation
class SettingModel : ObservableObject {
    @Published var username: String = ""
    @Published var timeLimit: Double = 10
    @Published var numberOfBubbles: Double = 5
    
}
