//
//  EmojiEditor.swift
//  Memorize
//
//  Created by Denis Avdeev on 28.11.2024.
//

import SwiftUI

struct EmojiEditor: View {
    @Binding var emoji: Emoji
    let gridItemSize: CGFloat
    
    @State private var emojiToAdd = ""
    
    private var emojiFont: Font { .system(size: gridItemSize) }
    
    var body: some View {
        addEmoji
        removeEmoji(isIncluded: true)
        if !emoji[isIncluded: false].isEmpty {
            removeEmoji(isIncluded: false)
        }
    }
    
    private var addEmoji: some View {
        TextField("Add Emoji Here", text: $emojiToAdd)
            .font(emojiFont)
            .onChange(of: emojiToAdd) {
                $1.last
                    .map { emoji.add($0) }
                
                emojiToAdd = emojiToAdd.last
                    .map(String.init)
                ?? ""
            }
    }
    
    private func removeEmoji(
        isIncluded: Bool
    ) -> some View {
        VStack(alignment: .trailing) {
            Text(isIncluded ? "Tap to Remove Emoji" : "Tap to Recover Emoji")
                .font(.caption)
                .foregroundStyle(.gray)
            
            LazyVGrid(
                columns: [.init(.adaptive(minimum: gridItemSize))]
            ) {
                ForEach(emoji[isIncluded: isIncluded], id: \.self) { symbol in
                    Text(String(symbol))
                        .font(emojiFont)
                        .onTapGesture {
                            withAnimation {
                                emoji
                                    .remove(symbol, isIncluded: isIncluded)
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State private var emoji = Theme.suggestions[0].emoji
        
        var body: some View {
            EmojiEditor(
                emoji: $emoji,
                gridItemSize: 40
            )
        }
    }
    
    return Preview()
}
