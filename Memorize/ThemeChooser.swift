//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Denis Avdeev on 27.11.2024.
//

import SwiftUI

struct ThemeChooser: View {
    
    var body: some View {
        NavigationStack {
            List(Theme.suggestions, id: \.name) { theme in
                NavigationLink {
                    EmojiMemoryGameView(viewModel: .init(theme: theme))
                        .navigationTitle(theme.name)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    details(of: theme)
                }
            }
            .navigationTitle("Themes")
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
    ThemeChooser()
}
