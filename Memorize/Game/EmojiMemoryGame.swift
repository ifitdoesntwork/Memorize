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
    
    let theme: Theme
    @Published private var model: MemoryGame<String>
    
    init(theme: Theme) {
        self.theme = theme
        model = Self.createMemoryGame(themed: theme)
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
        model = Self.createMemoryGame(themed: theme)
    }
}
