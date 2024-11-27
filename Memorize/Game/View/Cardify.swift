//
//  Cardify.swift
//  Memorize
//
//  Created by Denis Avdeev on 11.11.2024.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    let gradient: Gradient
    var rotation: Double
    
    init(
        isFaceUp: Bool,
        gradient: Gradient
    ) {
        rotation = isFaceUp ? 0 : 180
        self.gradient = gradient
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            
            Group {
                base
                    .fill(.background)
                base
                    .strokeBorder(gradient, lineWidth: Constants.lineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            
            base
                .fill(gradient)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    
    func cardify(
        isFaceUp: Bool,
        gradient: Gradient
    ) -> some View {
        modifier(Cardify(
            isFaceUp: isFaceUp,
            gradient: gradient
        ))
    }
}
