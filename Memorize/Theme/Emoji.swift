//
//  Emoji.swift
//  Memorize
//
//  Created by Denis Avdeev on 29.11.2024.
//

import Foundation

struct Emoji: Codable {
    private var symbols: [Bool: [Character]]
    
    subscript(isIncluded isIncluded: Bool) -> [Character] {
        symbols[isIncluded] ?? []
    }
    
    mutating func add(_ symbol: Character) {
        symbols[true]?
            .appendIfUniqueEmoji(symbol)
    }
    
    mutating func remove(_ symbol: Character, isIncluded: Bool) {
        symbols[isIncluded]?
            .removeAll { $0 == symbol }
        symbols[!isIncluded]?
            .appendIfUniqueEmoji(symbol)
    }
    
    init(symbols: [Character]) {
        self.symbols = [
            true: symbols,
            false: []
        ]
    }
}

private extension Array where Element == Character {
    
    mutating func appendIfUniqueEmoji(_ symbol: Character) {
        self = (self + [symbol])
            .filter(\.isEmoji)
            .uniqued
    }
    
    mutating func remove(symbol: Character) {
        removeAll { $0 == symbol }
    }
}

private extension Character {
    
    var isEmoji: Bool {
        // Swift does not have a way to ask if a Character isEmoji
        // but it does let us check to see if our component scalars isEmoji
        // unfortunately unicode allows certain scalars (like 1)
        // to be modified by another scalar to become emoji (e.g. 1️⃣)
        // so the scalar "1" will report isEmoji = true
        // so we can't just check to see if the first scalar isEmoji
        // the quick and dirty here
        // is to see if the scalar is at least the first true emoji we know of
        // (the start of the "miscellaneous items" section)
        // or check to see if this is a multiple scalar unicode sequence
        // (e.g. a 1 with a unicode modifier to force it to be presented as emoji 1️⃣)
        if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
            return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}

private extension Array where Element == Character {
    
    // removes any duplicate Characters
    // preserves the order of the Characters
    var uniqued: Self {
        // not super efficient
        // would only want to use it on small(ish) strings
        // and we wouldn't want to call it in a tight loop or something
        reduce(into: []) { sofar, element in
            if !sofar.contains(element) {
                sofar.append(element)
            }
        }
    }
}
