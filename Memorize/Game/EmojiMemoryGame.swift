//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Denis Avdeev on 07.04.2024.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<Character>.Card
    
    private static func createMemoryGame(
        themed theme: Theme
    ) -> MemoryGame<Character> {
        let emoji = theme.emoji
            .shuffled()
        
        return MemoryGame(
            numberOfPairsOfCards: theme.numberOfPairs 
                ?? .random(in: .zero...emoji.count)
        ) { pairIndex in
            if emoji.indices.contains(pairIndex) {
                return emoji[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    let theme: Theme
    @Published private var model: MemoryGame<Character>
    
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
