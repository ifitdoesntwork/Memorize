//
//  MemoryGame.swift
//  Memorize
//
//  Created by Denis Avdeev on 07.04.2024.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var goalDate: Date
    private(set) var endDate: Date?
    
    init(
        numberOfPairsOfCards: Int,
        cardContentFactory: (Int) -> CardContent
    ) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
        cards.shuffle()
        goalDate = Date(timeIntervalSinceNow: TimeInterval(10 * cards.count))
    }
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices
                .filter { cards[$0].isFaceUp }
                .only
        }
        set {
            cards.indices
                .forEach { cards[$0].isFaceUp = newValue == $0 }
        }
    }
    
    private var unmatchedCardsCount: Int {
        cards
            .filter { !$0.isMatched }
            .count
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        goalDate.addTimeInterval(20)
                        if unmatchedCardsCount == .zero {
                            endDate = goalDate
                        }
                    } else {
                        for index in [chosenIndex, potentialMatchIndex] {
                            if cards[index].isPreviouslySeen {
                                goalDate.addTimeInterval(-10)
                            } else {
                                cards[index].isPreviouslySeen = true
                            }
                        }
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    struct Card: Equatable,
                 Identifiable,
                 CustomDebugStringConvertible
    {
        var isFaceUp = false
        var isMatched = false
        var isPreviouslySeen = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content)"
            + " \(isFaceUp ? "up" : "down")"
            + "\(isMatched ? " matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
