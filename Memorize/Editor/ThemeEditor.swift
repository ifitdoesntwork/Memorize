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
    
    private let gridItemSize: CGFloat = 40
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $theme.name)
                    .focused($focusedField, equals: .name)
            }
            Section("Emoji") {
                EmojiEditor(emoji: $theme.emoji, gridItemSize: gridItemSize)
                    .focused($focusedField, equals: .addEmoji)
            }
            Section("Number of Cards") {
                numberOfCards
            }
            Section("Color") {
                colors
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
            "Random",
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
    
    @ViewBuilder
    var colors: some View {
        LazyVGrid(
            columns: [.init(.adaptive(minimum: gridItemSize))]
        ) {
            ForEach(theme.colors) { color in
                if let index = theme.colors
                    .firstIndex(where: { $0.id == color.id})
                {
                    ColorPicker(
                        "",
                        selection: $theme.colors[index].uiColor
                    )
                    .labelsHidden()
                }
            }
        }
        
        Stepper(
            "Colors",
            value: .init(
                get: {
                    theme.colors.count
                },
                set: {
                    if $0 > theme.colors.count {
                        theme.colors.append(.init(color: .gray))
                    } else {
                        theme.colors.removeLast()
                    }
                }
            ),
            in: 1...Int.max
        )
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
