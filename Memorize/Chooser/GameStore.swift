//
//  GameStore.swift
//  Memorize
//
//  Created by Denis Avdeev on 27.11.2024.
//

import SwiftUI

final class GameStore: ObservableObject {
    
    @Published private(set) var games = ([Theme].load() ?? Theme.suggestions)
        .map { EmojiMemoryGame(theme: $0) }
    
    var themes: [Theme] {
        get {
            games.themes
        }
        set {
            games.themes = newValue
            themes.autosave()
        }
    }
    
    func addTheme() {
        themes
            .append(.init(colors: [.gray].theme))
    }
    
    func removeTheme(atOffsets offsets: IndexSet) {
        themes
            .remove(atOffsets: offsets)
    }
    
    func resetThemes() {
        themes = Theme.suggestions
    }
}

extension EmojiMemoryGame: ThemedArrayElement {}
