//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Denis Avdeev on 07.04.2024.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static func createMemoryGame(
        themed theme: Theme
    ) -> MemoryGame<String> {
        MemoryGame(
            numberOfPairsOfCards: theme.numberOfPairs
        ) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    private static var models: (Theme, MemoryGame<String>) {
        let suggestion = Theme.suggestions
            .randomElement()
        ?? .random
        
        return (
            suggestion,
            createMemoryGame(themed: suggestion)
        )
    }
    
    private var theme: Theme
    @Published private var model: MemoryGame<String>
    
    init() {
        (theme, model) = Self.models
    }
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var color: Color {
        theme.uiColor
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func restart() {
        (theme, model) = Self.models
    }
}

private extension Theme {
    
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
    
    var uiColor: SwiftUI.Color {
        switch color {
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
