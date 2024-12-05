//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Denis Avdeev on 07.04.2024.
//

import SwiftUI

final class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<Character>.Card
    
    private static func createMemoryGame(
        themed theme: Theme
    ) -> MemoryGame<Character> {
        let emoji = theme.emoji[isIncluded: true]
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
    
    @Published private(set) var theme: Theme
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
            .map(\.ui)
    }
    
    var name: String {
        theme.name
    }
    
    var isDealt: Bool {
        model.isDealt
    }
    
    var goalDate: Date? {
        model.goalDate
    }
    
    var timerInterval: ClosedRange<Date> {
        let intervalEnd = goalDate
            ?? .init(timeIntervalSinceNow: model.gameSpan)
        return .now...max(intervalEnd, .now)
    }
    
    var pauseTime: Date? {
        isDealt
            ? model.endDate 
            : .init(timeIntervalSinceNow: model.gameSpan)
    }
    
    // MARK: - Intents
    
    func deal() {
        model.deal()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func updateTheme(to theme: Theme) {
        let needRestart = !theme
            .isCompatibleUpdate(from: self.theme)
        self.theme = theme
        if needRestart {
            restart()
        }
    }
    
    func restart() {
        model = Self.createMemoryGame(themed: theme)
    }
}
