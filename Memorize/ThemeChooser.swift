//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Denis Avdeev on 27.11.2024.
//

import SwiftUI

struct ThemeChooser: View {
    
    var body: some View {
        NavigationStack {
            List(Theme.suggestions, id: \.name) { theme in
                Text(theme.name)
            }
            .navigationTitle("Theme")
        }
    }
}

#Preview {
    ThemeChooser()
}
