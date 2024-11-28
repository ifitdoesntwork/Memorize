//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Denis Avdeev on 28.11.2024.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    
    var body: some View {
        Form {
            Text(theme.name)
        }
    }
}

#Preview {
    ThemeEditor(theme: .constant(.suggestions[0]))
}
