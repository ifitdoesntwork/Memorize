//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Denis Avdeev on 11.07.2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
