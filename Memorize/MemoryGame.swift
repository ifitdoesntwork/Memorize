//
//  MemoryGame.swift
//  Memorize
//
//  Created by Denis Avdeev on 02.08.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
    
    private(set) var cards: [Card]
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if
            let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                cards.indices.forEach { index in
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(
        numberOfPairsOfCards: Int,
        createCardContent: (Int) -> CardContent
    ) {
        cards = (0..<numberOfPairsOfCards).flatMap { pairIndex -> [Card] in
            let content = createCardContent(pairIndex)
            return [
                Card(content: content, id: pairIndex * 2),
                Card(content: content, id: pairIndex * 2 + 1)
            ]
        }
    }
}
