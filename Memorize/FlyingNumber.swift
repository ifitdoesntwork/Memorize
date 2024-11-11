//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Denis Avdeev on 11.11.2024.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    
    var body: some View {
        if number != .zero {
            Text(number, format: .number)
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
