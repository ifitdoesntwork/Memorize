//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Denis Avdeev on 27.11.2024.
//

import SwiftUI

struct ThemeChooser: View {
    @ObservedObject var store: GameStore
    @State private var selectedThemeId: UUID?
    @State private var editedTheme: Theme?
    
    var body: some View {
        NavigationSplitView {
            themes
                .navigationTitle("Themes")
        } detail: {
            if
                let selectedThemeId,
                let game = store.games
                    .first(where: { $0.theme.id == selectedThemeId })
            {
                EmojiMemoryGameView(viewModel: game)
            } else {
                Text("Choose a theme")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .sheet(item: $editedTheme) { theme in
            if let index = store.themes
                .firstIndex(where: { $0.id == theme.id })
            {
                ThemeEditor(theme: $store.themes[index])
            }
        }
    }
    
    private var themes: some View {
        List(selection: $selectedThemeId) {
            ForEach(store.themes) { theme in
                NavigationLink(value: theme.id) {
                    details(of: theme)
                }
                .swipeActions(edge: .leading) {
                    Button("Edit", systemImage: "slider.horizontal.3") {
                        editedTheme = theme
                    }
                }
            }
            .onDelete {
                store.removeTheme(atOffsets: $0)
            }
        }
        .toolbar {
            Button("Reset", systemImage: "arrow.circlepath") {
                store.resetThemes()
            }
            Button("Add", systemImage: "plus") {
                store.addTheme()
                editedTheme = store.themes.last
            }
        }
    }
    
    private func details(of theme: Theme) -> some View {
        VStack(alignment: .leading) {
            Text(theme.name)
                .font(.title)
                .foregroundStyle(
                    Gradient(colors: theme.colors)
                )
            
            let prefix = if let numberOfPairs = theme.numberOfPairs {
                "\(numberOfPairs * 2)"
            } else {
                "\(theme.emojiCount * 2) or less"
            }
            
            let subtitle = prefix
            + " from "
            + .init(theme.emoji[isIncluded: true])
            
            Text(subtitle)
                .lineLimit(1)
        }
    }
}

#Preview {
    ThemeChooser(store: .init())
}
