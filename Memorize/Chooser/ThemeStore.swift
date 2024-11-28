//
//  ThemeStore.swift
//  Memorize
//
//  Created by Denis Avdeev on 27.11.2024.
//

import SwiftUI

class ThemeStore: ObservableObject {
    @Published private var model = Theme.suggestions
    
    var themes: [Theme] {
        get { model }
        set { model = newValue }
    }
    
    func add() {
        model
            .append(.init(
                colors: [.blue, .orange, .green]
            ))
    }
    
    func remove(atOffsets offsets: IndexSet) {
        model
            .remove(atOffsets: offsets)
    }
}
