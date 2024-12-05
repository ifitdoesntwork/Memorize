//
//  MemoryGame.swift
//  Memorize
//
//  Created by Denis Avdeev on 07.04.2024.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var goalDate: Date?
    private(set) var endDate: Date?
    
    var isDealt: Bool {
        goalDate != nil
    }
    
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
    
    var gameSpan: TimeInterval {
        TimeInterval(3 * cards.count)
    }
    
    mutating func deal() {
        goalDate = Date(timeIntervalSinceNow: gameSpan)
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        goalDate?.addTimeInterval(
                            cards[chosenIndex].bonus + cards[potentialMatchIndex].bonus
                        )
                        if unmatchedCardsCount == .zero {
                            endDate = goalDate
                        }
                    } else {
                        for index in [chosenIndex, potentialMatchIndex] {
                            if cards[index].isPreviouslySeen {
                                goalDate?.addTimeInterval(-5)
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
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var isPreviouslySeen = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content)"
            + " \(isFaceUp ? "up" : "down")"
            + "\(isMatched ? " matched" : "")"
        }
        
        // MARK: - Bonus Time
        
        // call this when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isFaceUp && !isMatched && bonusPercentRemaining > 0, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // call this when the card goes back face down or gets matched
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        // the bonus earned so far (one point for every second of the bonusTimeLimit that was not used)
        // this gets smaller and smaller the longer the card remains face up without being matched
        var bonus: TimeInterval {
            bonusTimeLimit * bonusPercentRemaining
        }
        
        // percentage of the bonus time remaining
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
        }
        
        // how long this card has ever been face up and unmatched during its lifetime
        // basically, pastFaceUpTime + time since lastFaceUpDate
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // can be zero which would mean "no bonus available" for matching this card quickly
        var bonusTimeLimit: TimeInterval = 6
        
        // the last time this card was turned face up
        var lastFaceUpDate: Date?
        
        // the accumulated time this card was face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
