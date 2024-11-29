//
//  EmojiEditor.swift
//  Memorize
//
//  Created by Denis Avdeev on 28.11.2024.
//

import SwiftUI

struct EmojiEditor: View {
    @Binding var emoji: [Character]
    let gridItemSize: CGFloat
    
    @State private var emojiToAdd = ""
    
    private var emojiFont: Font { .system(size: gridItemSize) }
    
    var body: some View {
        VStack {
            addEmoji
            Divider()
            removeEmoji
        }
    }
    
    private var addEmoji: some View {
        TextField("Add Emoji Here", text: $emojiToAdd)
            .font(emojiFont)
            .onChange(of: emojiToAdd) {
                emoji
                    .appendIfUniqueEmoji($0)
                
                emojiToAdd = emojiToAdd.last
                    .map(String.init)
                ?? ""
            }
    }
    
    private var removeEmoji: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emoji")
                .font(.caption)
                .foregroundStyle(.gray)
            
            LazyVGrid(
                columns: [.init(.adaptive(minimum: gridItemSize))]
            ) {
                ForEach(emoji, id: \.self) { symbol in
                    Text(String(symbol))
                        .font(emojiFont)
                        .onTapGesture {
                            withAnimation {
                                emoji
                                    .remove(symbol: symbol)
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var emoji = Theme.suggestions[0].emoji
        
        var body: some View {
            EmojiEditor(
                emoji: $emoji,
                gridItemSize: 40
            )
        }
    }
    
    return Preview()
}
