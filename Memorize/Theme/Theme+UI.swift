//
//  Theme+UI.swift
//  Memorize
//
//  Created by Denis Avdeev on 27.11.2024.
//

import SwiftUI

extension Color {
    
    var theme: Theme.Color {
        .init(color: self)
    }
    
    fileprivate init(color: Theme.Color) {
        self.init(
            .sRGB,
            red: color.red,
            green: color.green,
            blue: color.blue,
            opacity: color.alpha
        )
    }
}

extension [Color] {
    
    var theme: [Theme.Color] {
        map(\.theme)
    }
}

extension Theme.Color {
    
    var ui: SwiftUI.Color {
        get {
            .init(color: self)
        }
        set {
            self = .init(color: newValue)
        }
    }
    
    fileprivate init(color: Color) {
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
                .map(\.ui)
        )
    }
}
