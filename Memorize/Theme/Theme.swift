//
//  Theme.swift
//  Memorize
//
//  Created by Denis Avdeev on 08.04.2024.
//

import Foundation

struct Theme: Identifiable {
    
    struct Color: Identifiable {
        let id = UUID()
        
        let red: Double
        let green: Double
        let blue: Double
        let alpha: Double
        
        static let `default` = Self(
            red: 0.5,
            green: 0.5,
            blue: 0.5,
            alpha: 1
        )
    }
    
    let id = UUID()
    
    var name: String
    
    var emoji: [Character] {
        didSet {
            if emoji.count < 2 {
                emoji = oldValue
            }
            if !numberOfPairs.isLegit(for: emoji.count) {
                numberOfPairs = emoji.count
            }
        }
    }
    
    var numberOfPairs: Int? {
        didSet {
            if !numberOfPairs.isLegit(for: emoji.count) {
                numberOfPairs = oldValue
            }
        }
    }
    
    var colors: [Color] {
        didSet {
            if colors.isEmpty {
                colors = oldValue
            }
        }
    }
    
    init(
        name: String = "",
        emoji: [Character] = [],
        numberOfPairs: Int? = nil,
        colors: [Color] = []
    ) {
        self.name = name
        
        let emoji = emoji.count < 2 ? .minimum : emoji
        self.emoji = emoji
        
        self.numberOfPairs = numberOfPairs.isLegit(for: emoji.count)
            ? numberOfPairs : emoji.count
        
        self.colors = colors.isEmpty
            ? [.default] : colors
    }
    
    var isRandomNumberOfCards: Bool {
        get { numberOfPairs == nil }
        set { numberOfPairs = newValue ? nil : emoji.count }
    }
    
    var allowedNumberOfPairs: ClosedRange<Int> {
        emoji.count
            .allowedNumberOfPairs
    }
}

private extension Int? {
    
    func isLegit(for emojiCount: Int) -> Bool {
        map {
            emojiCount.allowedNumberOfPairs
                .contains($0)
        } ?? true
    }
}

private extension Int {
    
    var allowedNumberOfPairs: ClosedRange<Int> {
        2...self
    }
}

private extension Array where Element == Character {
    
    static let minimum: Self = [
        "❓", "❗️"
    ]
}
