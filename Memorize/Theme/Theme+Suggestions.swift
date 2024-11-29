//
//  Theme+Suggestions.swift
//  Memorize
//
//  Created by Denis Avdeev on 29.11.2024.
//

import SwiftUI

extension Theme {
    
    static let suggestions = [
        Theme(
            name: "Halloween",
            emoji: .halloween,
            numberOfPairs: 12,
            colors: [.orange, .red]
        ),
        Theme(
            name: "Sports",
            emoji: .sports,
            numberOfPairs: nil,
            colors: [.red, .blue]
        ),
        Theme(
            name: "Animals",
            emoji: .animals,
            numberOfPairs: 8,
            colors: [.green]
        ),
        Theme(
            name: "October",
            emoji: .halloween,
            numberOfPairs: nil,
            colors: [.red]
        ),
        Theme(
            name: "Big Sports",
            emoji: .sports,
            numberOfPairs: 10,
            colors: [.blue]
        ),
        Theme(
            name: "My Pets",
            emoji: .animals,
            numberOfPairs: 3,
            colors: [.orange]
        )
    ]
}

private extension Array where Element == Character {
    
    static let halloween: Self = [
        "👻", "🎃", "🕷️", "😈", "💀", "🕸️",
        "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"
    ]
    
    static let sports: Self = [
        "⚽️", "🏀", "🏈", "⚾️", "🎾",
        "🏸", "🧘‍♀️", "🏄‍♀️", "🏊‍♀️", "🚴‍♀️"
    ]
    
    static let animals: Self = [
        "🐶", "🐱", "🐭", "🐹",
        "🐰", "🦊", "🐻", "🐼"
    ]
}
