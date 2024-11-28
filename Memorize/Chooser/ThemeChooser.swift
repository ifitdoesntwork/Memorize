//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Denis Avdeev on 27.11.2024.
//

import SwiftUI

struct ThemeChooser: View {
    @ObservedObject var store: ThemeStore
    @State var selectedThemeId: UUID?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink {
                        EmojiMemoryGameView(viewModel: .init(theme: theme))
                            .navigationTitle(theme.name)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        details(of: theme)
                    }
                    .swipeActions(edge: .leading) {
                        Button("Edit", systemImage: "slider.horizontal.3") {
                            selectedThemeId = theme.id
                        }
                    }
                }
                .onDelete { indexSet in
                    store.remove(atOffsets: indexSet)
                }
            }
            .sheet(
                isPresented: Binding(
                    get: { selectedThemeId != nil },
                    set: { _ in selectedThemeId = nil }
                )
            ) {
                if let index = store.themes
                    .firstIndex(where: { $0.id == selectedThemeId })
                {
                    ThemeEditor(theme: $store.themes[index])
                }
            }
            .navigationTitle("Themes")
            .toolbar {
                Button("Add", systemImage: "plus") {
                    store.add()
                    selectedThemeId = store.themes.last?.id
                }
            }
        }
    }
    
    private func details(of theme: Theme) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(theme.name)
                    .foregroundStyle(
                        Gradient(colors: theme.colors.map(\.uiColor))
                    )
                
                Spacer()
                
                if let numberOfPairs = theme.numberOfPairs {
                    Text("\(numberOfPairs * 2) Cards")
                } else {
                    Text("\(theme.emoji.count * 2) or Less Cards")
                }
            }
            Text(String(theme.emoji))
                .lineLimit(1)
        }
    }
}

#Preview {
    ThemeChooser(store: .init())
}
