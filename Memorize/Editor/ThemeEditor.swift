//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Denis Avdeev on 28.11.2024.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    
    enum FocusedField {
        case name
        case addEmoji
    }
    
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $theme.name)
                    .focused($focusedField, equals: .name)
            }
            Section("Emoji") {
                EmojiEditor(emoji: $theme.emoji)
                    .focused($focusedField, equals: .addEmoji)
            }
            Section("Number of Cards") {
                numberOfCards
            }
        }
        .onAppear {
            focusedField = theme.name.isEmpty 
                ? .name : .addEmoji
        }
    }
    
    @ViewBuilder
    var numberOfCards: some View {
        Toggle(
            "Randomize",
            isOn: $theme.isRandomNumberOfCards
        )
        
        if let numberOfPairs = theme.numberOfPairs {
            Stepper(
                "Pairs of Cards: \(numberOfPairs)",
                value: .init($theme.numberOfPairs)!,
                in: theme.allowedNumberOfPairs
            )
        }
    }
}

#Preview {
    struct Preview: View {
        @State var theme = Theme.suggestions[0]
        
        var body: some View {
            ThemeEditor(theme: $theme)
        }
    }
    
    return Preview()
}
