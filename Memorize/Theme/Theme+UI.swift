//
//  Theme+UI.swift
//  Memorize
//
//  Created by Denis Avdeev on 27.11.2024.
//

import SwiftUI

extension Theme {
    
    init(
        name: String = "",
        emoji: [Character] = [],
        numberOfPairs: Int? = nil,
        colors: [SwiftUI.Color]
    ) {
        self.init(
            name: name,
            emoji: emoji,
            numberOfPairs: numberOfPairs,
            colors: colors.map(Color.init)
        )
    }
}

extension Color {
    
    init(color: Theme.Color) {
        self.init(
            .sRGB,
            red: color.red,
            green: color.green,
            blue: color.blue,
            opacity: color.alpha
        )
    }
}

extension Theme.Color {
    
    var uiColor: SwiftUI.Color {
        get {
            .init(color: self)
        }
        set {
            self = .init(color: newValue)
        }
    }
    
    init(color: Color) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        UIColor(color).getRed(
            &red,
            green: &green,
            blue: &blue,
            alpha: &alpha
        )
        
        self.init(
            red: Double(red),
            green: Double(green),
            blue: Double(blue),
            alpha: Double(alpha)
        )
    }
}

extension Gradient {
    
    init(colors: [Theme.Color]) {
        self = .init(
            colors: colors
                .map(\.uiColor)
        )
    }
}
