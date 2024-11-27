//
//  Theme+UI.swift
//  Memorize
//
//  Created by Denis Avdeev on 27.11.2024.
//

import SwiftUI

extension Theme {
    
    var emojis: [String] {
        switch emoji {
        case .halloween:
            return [
                "👻", "🎃", "🕷️", "😈", "💀", "🕸️",
                "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"
            ]
        case .sports:
            return [
                "⚽️", "🏀", "🏈", "⚾️", "🎾",
                "🏸", "🧘‍♀️", "🏄‍♀️", "🏊‍♀️", "🚴‍♀️"
            ]
        case .animals:
            return [
                "🐶", "🐱", "🐭", "🐹",
                "🐰", "🦊", "🐻", "🐼"
            ]
        }
    }
}

extension Theme.Color {
    
    var uiColor: Color {
        switch self {
        case .orange:
            return .orange
        case .red:
            return .red
        case .blue:
            return .blue
        case .green:
            return .green
        }
    }
}
