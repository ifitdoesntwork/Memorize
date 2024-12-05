//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Denis Avdeev on 02.04.2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject private var store = GameStore()
    
    var body: some Scene {
        WindowGroup {
            ThemeChooser(store: store)
        }
    }
}
