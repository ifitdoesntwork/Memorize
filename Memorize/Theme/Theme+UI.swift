//
//  Theme+UI.swift
//  Memorize
//
//  Created by Denis Avdeev on 27.11.2024.
//

import SwiftUI

extension Theme.Color {
    
    var uiColor: Color {
        switch self {
        case .orange:
            return .orange
        case .red:
            return .red
        case .blue:
            return .blue
        case .green:
            return .green
        }
    }
}
