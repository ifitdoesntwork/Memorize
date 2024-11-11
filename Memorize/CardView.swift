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
        Pie(endAngle: .degrees(240))
            .fill(gradient)
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .aspectRatio(contentMode: .fit)
                    .padding(Constants.Pie.inset)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(.spin(duration: 1), value: card.isMatched)
            )
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp, gradient: gradient)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

extension Animation {
    
    static func spin(duration: TimeInterval) -> Self {
        .linear(duration: duration)
        .repeatForever(autoreverses: false)
    }
}

#Preview {
    typealias Card = CardView.Card
    
    return VStack {
        HStack {
            CardView(
                Card(
                    isFaceUp: true,
                    content: "X",
                    id: "test1"
                ),
                colors: [.orange]
            )
            CardView(
                Card(
                    content: "X",
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
                    content: "X",
                    id: "test1"
                ),
                colors: [.red, .blue]
            )
            CardView(
                Card(
                    isMatched: true,
                    content: "X",
                    id: "test1"
                ),
                colors: [.red, .blue]
            )
        }
    }
    .padding()
}
