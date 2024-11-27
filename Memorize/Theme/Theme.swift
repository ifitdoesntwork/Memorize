//
//  Theme.swift
//  Memorize
//
//  Created by Denis Avdeev on 08.04.2024.
//

import Foundation

struct Theme: Identifiable {
    
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
    
    let id = UUID()
    let name: String
    let emoji: Emoji
    let numberOfPairs: Int?
    let colors: [Color]
    
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
