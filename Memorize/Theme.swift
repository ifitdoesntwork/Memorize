//
//  Theme.swift
//  Memorize
//
//  Created by Denis Avdeev on 08.04.2024.
//

import Foundation

struct Theme {
    
    enum Emoji {
        case halloween
        case sports
        case animals
    }
    
    enum Color {
        case orange
        case red
        case blue
        case green
    }
    
    let name: String
    let emoji: Emoji
    let numberOfPairs: Int
    let color: Color
}
