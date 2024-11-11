//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Denis Avdeev on 02.04.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            panel
            cards
                .animation(.default, value: viewModel.cards)
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
        AspectVGrid(
            viewModel.cards,
            aspectRatio: aspectRatio
        ) { card in
            CardView(card, colors: viewModel.colors)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}

struct EmojiMemotyGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
