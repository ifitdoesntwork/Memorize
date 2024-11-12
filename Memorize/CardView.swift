//
//  CardView.swift
//  Memorize
//
//  Created by Denis Avdeev on 11.11.2024.
//

import SwiftUI

struct CardView: View {
    
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    let gradient: Gradient
    
    private struct Constants {
        static let inset: CGFloat = 5
        
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 2
            static let scaleFactor = smallest / largest
        }
        
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 12
        }
    }
    
    init(
        _ card: Card,
        colors: [Color]
    ) {
        self.card = card
        self.gradient = Gradient(colors: colors)
    }
    
    var body: some View {
        TimelineView(.animation) { _ in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .fill(gradient)
                    .opacity(Constants.Pie.opacity)
                    .overlay(cardContents.padding(Constants.Pie.inset))
                    .padding(Constants.inset)
                    .cardify(isFaceUp: card.isFaceUp, gradient: gradient)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .aspectRatio(contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.easeInOut(duration: 1), value: card.isMatched)
    }
}

#Preview {
    typealias Card = CardView.Card
    
    return VStack {
        HStack {
            CardView(
                Card(
                    isFaceUp: true,
                    content: "?",
                    id: "test1"
                ),
                colors: [.orange]
            )
            CardView(
                Card(
                    content: "?",
                    id: "test1"
                ),
                colors: [.orange]
            )
        }
        HStack {
            CardView(
                Card(
                    isFaceUp: true,
                    isMatched: true,
                    content: "?",
                    id: "test1"
                ),
                colors: [.red, .blue]
            )
            CardView(
                Card(
                    isMatched: true,
                    content: "?",
                    id: "test1"
                ),
                colors: [.red, .blue]
            )
        }
    }
    .padding()
}
