//
//  Cardify.swift
//  Memorize
//
//  Created by Denis Avdeev on 11.11.2024.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    let gradient: Gradient
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            
            Group {
                base
                    .fill(.white)
                base
                    .strokeBorder(gradient, lineWidth: Constants.lineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            
            base
                .fill(gradient)
                .opacity(isFaceUp ? 0 : 1)
        }
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
