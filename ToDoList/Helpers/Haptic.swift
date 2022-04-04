//
//  Haptic.swift
//  ToDoList
//
//  Created by Szymon Tadrzak on 04/04/2022.
//

import UIKit

struct Haptics {
    
    static func playLightImpact() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    static func playSuccessNotification() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
