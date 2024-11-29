//
//  ThemeStore.swift
//  Memorize
//
//  Created by Denis Avdeev on 27.11.2024.
//

import SwiftUI

class ThemeStore: ObservableObject {
    @Published private var model = [Theme].load() 
        ?? Theme.suggestions
    {
        didSet { model.autosave() }
    }
    
    var themes: [Theme] {
        get { model }
        set { model = newValue }
    }
    
    func add() {
        model
            .append(.init(colors: [.gray]))
    }
    
    func remove(atOffsets offsets: IndexSet) {
        model
            .remove(atOffsets: offsets)
    }
    
    func reset() {
        model = Theme.suggestions
    }
}
