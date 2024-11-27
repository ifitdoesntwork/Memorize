//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Denis Avdeev on 02.04.2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject private var themeStore = ThemeStore()
    
    var body: some Scene {
        WindowGroup {
            ThemeChooser(store: themeStore)
        }
    }
}
