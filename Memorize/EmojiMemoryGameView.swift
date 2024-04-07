//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Denis Avdeev on 02.04.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    struct Theme {
        let title: String
        let image: String
        let color: Color
        let emojis: [String]
    }
    
    let themes = [
        Theme(
            title: "Halloween",
            image: "basket.fill",
            color: .orange,
            emojis: [
                "👻", "🎃", "🕷️", "😈", "💀", "🕸️",
                "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"
            ]
        ),
        Theme(
            title: "Sports",
            image: "trophy.fill",
            color: .red,
            emojis: [
                "⚽️", "🏀", "🏈", "⚾️", "🎾",
                "🏸", "🧘‍♀️", "🏄‍♀️", "🏊‍♀️", "🚴‍♀️"
            ]
        ),
        Theme(
            title: "Animals",
            image: "hare.fill",
            color: .green,
            emojis: [
                "🐶", "🐱", "🐭", "🐹",
                "🐰", "🦊", "🐻", "🐼"
            ]
        )
    ]
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            ScrollView {
                cards
            }
            
            Button("Shuffle") {
                viewModel.shuffle()
            }
            
            Spacer()
            themeSelector
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(
            columns: [GridItem(
                .adaptive(minimum: 85),
                spacing: 0
            )],
            spacing: 0
        ) {
            ForEach(
                viewModel.cards.indices,
                id: \.self
            ) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.orange)
    }
    
    func tab(
        themed theme: Theme
    ) -> some View {
        Button {
            
        } label: {
            VStack {
                Image(systemName: theme.image)
                    .font(.largeTitle)
                Text(theme.title)
            }
            .foregroundColor(theme.color)
        }
    }
    
    var themeSelector: some View {
        HStack {
            Spacer()
            
            ForEach(
                themes.indices,
                id: \.self
            ) { index in
                tab(themed: themes[index])
                Spacer()
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base
                    .fill(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            base
                .fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

struct EmojiMemotyGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
