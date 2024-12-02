//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Denis Avdeev on 27.11.2024.
//

import SwiftUI

struct ThemeChooser: View {
    @ObservedObject var store: ThemeStore
    @State private var selectedThemeId: UUID?
    @State private var editedThemeId: UUID?
    
    var body: some View {
        NavigationSplitView {
            themes
                .navigationTitle("Themes")
                .toolbar {
                    Button("Reset", systemImage: "arrow.circlepath") {
                        store.reset()
                    }
                    Button("Add", systemImage: "plus") {
                        store.add()
                        editedThemeId = store.themes.last?.id
                    }
                }
        } detail: {
            if 
                let selectedThemeId,
                let theme = store.themes
                    .first(where: { $0.id == selectedThemeId })
            {
                EmojiMemoryGameView(viewModel: .init(theme: theme))
            } else {
                Text("Choose a theme")
                    .navigationBarTitleDisplayMode(.inline)
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
                        editedThemeId = theme.id
                    }
                }
            }
            .onDelete {
                store.remove(atOffsets: $0)
            }
        }
        .sheet(
            isPresented: .init(
                get: { editedThemeId != nil },
                set: { _ in editedThemeId = nil }
            )
        ) {
            if let index = store.themes
                .firstIndex(where: { $0.id == editedThemeId })
            {
                ThemeEditor(theme: $store.themes[index])
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
