//
//  EmojiEditor.swift
//  Memorize
//
//  Created by Denis Avdeev on 28.11.2024.
//

import SwiftUI

struct EmojiEditor: View {
    @Binding var emoji: [Character]
    
    @State private var emojiToAdd = ""
    
    private let emojiFont = Font.system(size: 40)
    
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
                emoji = (emoji + $0)
                    .filter(\.isEmoji)
                    .uniqued
            }
    }
    
    private var removeEmoji: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emoji")
                .font(.caption)
                .foregroundStyle(.gray)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(emoji, id: \.self) { symbol in
                    Text(String(symbol))
                        .font(emojiFont)
                        .onTapGesture {
                            withAnimation {
                                emoji.removeAll { $0 == symbol }
                                emojiToAdd.removeAll { $0 == symbol }
                            }
                        }
                }
            }
        }
    }
}

private extension Character {
    
    var isEmoji: Bool {
        // Swift does not have a way to ask if a Character isEmoji
        // but it does let us check to see if our component scalars isEmoji
        // unfortunately unicode allows certain scalars (like 1)
        // to be modified by another scalar to become emoji (e.g. 1️⃣)
        // so the scalar "1" will report isEmoji = true
        // so we can't just check to see if the first scalar isEmoji
        // the quick and dirty here
        // is to see if the scalar is at least the first true emoji we know of
        // (the start of the "miscellaneous items" section)
        // or check to see if this is a multiple scalar unicode sequence
        // (e.g. a 1 with a unicode modifier to force it to be presented as emoji 1️⃣)
        if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
            return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}

private extension Array where Element == Character {
    
    // removes any duplicate Characters
    // preserves the order of the Characters
    var uniqued: Self {
        // not super efficient
        // would only want to use it on small(ish) strings
        // and we wouldn't want to call it in a tight loop or something
        reduce(into: []) { sofar, element in
            if !sofar.contains(element) {
                sofar.append(element)
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var emoji = Theme.suggestions[0].emoji
        
        var body: some View {
            EmojiEditor(emoji: $emoji)
        }
    }
    
    return Preview()
}
