//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Denis Avdeev on 27.11.2024.
//

import SwiftUI

struct ThemeChooser: View {
    @ObservedObject var store: ThemeStore
    
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
                }
                .onDelete { indexSet in
                    store.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("Themes")
            .toolbar {
                Button("", systemImage: "plus") {
                    store.add()
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
                    Text("\(theme.emojis.count * 2) or Less Cards")
                }
            }
            Text(theme.emojis.joined())
                .lineLimit(1)
        }
    }
}

#Preview {
    ThemeChooser(store: .init())
}
