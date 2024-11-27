//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Denis Avdeev on 02.04.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2/3
        static let deckWidth: CGFloat = 50
        static let dealAnimation: Animation = .easeInOut(duration: 1)
        static let dealInterval: TimeInterval = 0.15
    }
    
    var body: some View {
        VStack {
            ZStack {
                panel
                deck
            }
            cards
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
            
            Button {
                withAnimation {
                    dealt.removeAll()
                    lastTimeChange = (TimeInterval.zero, causedByCardId: "")
                    viewModel.restart()
                }
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
            aspectRatio: Constants.aspectRatio
        ) { card in
            if isDealt(card) {
                CardView(card, colors: viewModel.colors)
                    .matchedGeometryEffect(id: card.id, in: dealing)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(4)
                    .overlay(FlyingNumber(number: timeChange(causedBy: card)))
                    .zIndex(timeChange(causedBy: card) != .zero ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }
    
    @State private var dealt = Set<CardView.Card.ID>()
    
    private func isDealt(_ card: CardView.Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [CardView.Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealing
    
    var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card, colors: viewModel.colors)
                    .matchedGeometryEffect(id: card.id, in: dealing)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(
            width: Constants.deckWidth,
            height: Constants.deckWidth / Constants.aspectRatio
        )
        .onTapGesture {
            deal()
        }
    }
    
    private func deal() {
        viewModel.cards
            .enumerated()
            .forEach { index, card in
                withAnimation(
                    Constants.dealAnimation
                        .delay(Double(index) * Constants.dealInterval)
                ) {
                    _ = dealt.insert(card.id)
                }
            }
    }
    
    private func choose(_ card: CardView.Card) {
        withAnimation {
            let dateBeforeChoosing = viewModel.goalDate
            viewModel.choose(card)
            let timeChange = viewModel.goalDate
                .timeIntervalSince(dateBeforeChoosing)
            lastTimeChange = (timeChange, causedByCardId: card.id)
        }
    }
    
    @State private var lastTimeChange = (TimeInterval.zero, causedByCardId: "")
    
    private func timeChange(causedBy card: CardView.Card) -> Int {
        let (amount, id) = lastTimeChange
        return card.id == id ? Int(amount) : .zero
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(
            viewModel: .init(theme: .suggestions.randomElement()!)
        )
    }
}
