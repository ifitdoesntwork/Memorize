//
//  ContentView.swift
//  Memorize
//
//  Created by Denis Avdeev on 02.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    struct Theme {
        let title: String
        let emojis: [String]
    }
    
    let themes = [
        Theme(
            title: "Halloween",
            emojis: [
                "👻", "🎃", "🕷️", "😈", "💀", "🕸️",
                "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"
            ]
        ),
        Theme(
            title: "Sports",
            emojis: [
                "⚽️", "🏀", "🏈", "⚾️", "🎾",
                "🏸", "🧘‍♀️", "🏄‍♀️", "🏊‍♀️", "🚴‍♀️"
            ]
        ),
        Theme(
            title: "Animals",
            emojis: [
                "🐶", "🐱", "🐭", "🐹",
                "🐰", "🦊", "🐻", "🐼"
            ]
        )
    ]
    
    @State var emojis = [String]()
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            ScrollView {
                cards
            }
            
            Spacer()
            themeSelector
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 120))]
        ) {
            let cards = (emojis + emojis)
                .shuffled()
            
            ForEach(
                cards.indices,
                id: \.self
            ) { index in
                CardView(content: cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func tab(
        themed theme: Theme
    ) -> some View {
        Button {
            emojis = theme.emojis
                .shuffled()
        } label: {
            Text(theme.title)
        }
    }
    
    var themeSelector: some View {
        HStack {
            Spacer()
            
            ForEach(
                themes.indices,
                id: \.self
            ) { index in
                tab(themed: themes[index])
                Spacer()
            }
        }
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base
                    .fill(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            
            base
                .fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp
                .toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
