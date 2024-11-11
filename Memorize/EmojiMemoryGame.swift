//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Denis Avdeev on 07.04.2024.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    private static func createMemoryGame(
        themed theme: Theme
    ) -> MemoryGame<String> {
        let emojis = theme.emojis
            .shuffled()
        
        return MemoryGame(
            numberOfPairsOfCards: theme.numberOfPairs ?? .random(in: 0...emojis.count)
        ) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
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
    
    var cards: [Card] {
        model.cards
    }
    
    var colors: [Color] {
        theme.colors
            .map(\.uiColor)
    }
    
    var name: String {
        theme.name
    }
    
    var goalDate: Date {
        model.goalDate
    }
    
    var endDate: Date? {
        model.endDate
    }
    
    // MARK: - Intents
    
    func choose(_ card: Card) {
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
}

private extension Theme.Color {
    
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
