//
//  Theme.swift
//  Memorize
//
//  Created by Denis Avdeev on 08.04.2024.
//

import Foundation

struct Theme: Identifiable {
    
    enum Color {
        case orange
        case red
        case blue
        case green
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
    
    let colors: [Color]
    
    init(
        name: String = "",
        emoji: [Character] = [],
        numberOfPairs: Int? = nil,
        colors: [Color]
    ) {
        self.name = name
        
        let emoji = emoji.count < 2 ? .minimum : emoji
        self.emoji = emoji
        
        self.numberOfPairs = numberOfPairs.isLegit(for: emoji.count)
            ? numberOfPairs : emoji.count
        
        self.colors = colors
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
    
    static let halloween: Self = [
        "👻", "🎃", "🕷️", "😈", "💀", "🕸️",
        "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"
    ]
    
    static let sports: Self = [
        "⚽️", "🏀", "🏈", "⚾️", "🎾",
        "🏸", "🧘‍♀️", "🏄‍♀️", "🏊‍♀️", "🚴‍♀️"
    ]
    
    static let animals: Self = [
        "🐶", "🐱", "🐭", "🐹",
        "🐰", "🦊", "🐻", "🐼"
    ]
    
    static let minimum: Self = [
        "❓", "❗️"
    ]
}

extension Theme {
    
    static let suggestions = [
        Theme(
            name: "Halloween",
            emoji: .halloween,
            numberOfPairs: 12,
            colors: [.orange, .red]
        ),
        Theme(
            name: "Sports",
            emoji: .sports,
            numberOfPairs: nil,
            colors: [.red, .blue]
        ),
        Theme(
            name: "Animals",
            emoji: .animals,
            numberOfPairs: 8,
            colors: [.green]
        ),
        Theme(
            name: "October",
            emoji: .halloween,
            numberOfPairs: nil,
            colors: [.red]
        ),
        Theme(
            name: "Big Sports",
            emoji: .sports,
            numberOfPairs: 10,
            colors: [.blue]
        ),
        Theme(
            name: "My Pets",
            emoji: .animals,
            numberOfPairs: 3,
            colors: [.orange]
        )
    ]
}
