//
//  Theme.swift
//  Memorize
//
//  Created by Denis Avdeev on 08.04.2024.
//

import Foundation

struct Theme {
    
    enum Emoji {
        case halloween
        case sports
        case animals
    }
    
    enum Color {
        case orange
        case red
        case blue
        case green
    }
    
    let name: String
    let emoji: Emoji
    let numberOfPairs: Int
    let color: Color
    
    static let suggestions = [
        Theme(
            name: "Halloween",
            emoji: .halloween,
            numberOfPairs: 12,
            color: .orange
        ),
        Theme(
            name: "Sports",
            emoji: .sports,
            numberOfPairs: 4,
            color: .red
        ),
        Theme(
            name: "Animals",
            emoji: .animals,
            numberOfPairs: 8,
            color: .green
        ),
        Theme(
            name: "October",
            emoji: .halloween,
            numberOfPairs: 6,
            color: .red
        ),
        Theme(
            name: "Big Sports",
            emoji: .sports,
            numberOfPairs: 10,
            color: .blue
        ),
        Theme(
            name: "My Pets",
            emoji: .animals,
            numberOfPairs: 3,
            color: .orange
        )
    ]
}
