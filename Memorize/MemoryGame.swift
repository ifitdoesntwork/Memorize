//
//  MemoryGame.swift
//  Memorize
//
//  Created by Denis Avdeev on 02.08.2021.
//

import Foundation

struct MemoryGame<CardContent> {
    
    struct Card {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
    
    private(set) var cards: [Card]
    
    func choose(_ card: Card) {
        
    }
    
    init(
        numberOfPairsOfCards: Int,
        createCardContent: (Int) -> CardContent
    ) {
        cards = (0..<numberOfPairsOfCards).flatMap { pairIndex -> [Card] in
            let content = createCardContent(pairIndex)
            return [
                Card(content: content),
                Card(content: content)
            ]
        }
    }
}
