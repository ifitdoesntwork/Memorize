//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Denis Avdeev on 02.04.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            panel
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
        }
        .padding()
    }
    
    var panel: some View {
        HStack {
            Text(
                timerInterval: Date.now...viewModel.goalDate,
                pauseTime: viewModel.endDate
            )
            
            Spacer()
            
            Text(viewModel.name)
            
            Button {
                viewModel.restart()
            } label: {
                Image(systemName: "arrow.counterclockwise")
            }
        }
        .font(.largeTitle)
        .foregroundColor(viewModel.colors.first)
    }
    
    var cards: some View {
        LazyVGrid(
            columns: [GridItem(
                .adaptive(minimum: 85),
                spacing: 0
            )],
            spacing: 0
        ) {
            ForEach(viewModel.cards) { card in
                CardView(card, colors: viewModel.colors)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let gradient: Gradient
    
    init(
        _ card: MemoryGame<String>.Card,
        colors: [Color]
    ) {
        self.card = card
        self.gradient = Gradient(colors: colors)
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base
                    .fill(.white)
                base
                    .strokeBorder(gradient, lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            base
                .fill(gradient)
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

struct EmojiMemotyGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
