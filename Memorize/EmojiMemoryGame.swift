//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Denis Avdeev on 07.04.2024.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static let emojis = [
        "👻", "🎃", "🕷️", "😈", "💀", "🕸️",
        "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"
    ]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: emojis.count) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
