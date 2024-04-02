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
        let image: String
        let color: Color
        let emojis: [String]
    }
    
    let themes = [
        Theme(
            title: "Halloween",
            image: "basket.fill",
            color: .orange,
            emojis: [
                "👻", "🎃", "🕷️", "😈", "💀", "🕸️",
                "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"
            ]
        ),
        Theme(
            title: "Sports",
            image: "trophy.fill",
            color: .red,
            emojis: [
                "⚽️", "🏀", "🏈", "⚾️", "🎾",
                "🏸", "🧘‍♀️", "🏄‍♀️", "🏊‍♀️", "🚴‍♀️"
            ]
        ),
        Theme(
            title: "Animals",
            image: "hare.fill",
            color: .green,
            emojis: [
                "🐶", "🐱", "🐭", "🐹",
                "🐰", "🦊", "🐻", "🐼"
            ]
        )
    ]
    
    @State var emojis = [String]()
    @State var color = Color.white
    
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
    
    func widthThatBestFits(
        cardCount: Int
    ) -> CGFloat {
        100 - CGFloat(cardCount) * 4
    }
    
    var cards: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(
                minimum: widthThatBestFits(
                    cardCount: emojis.count
                )
            ))]
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
        .foregroundColor(color)
    }
    
    func tab(
        themed theme: Theme
    ) -> some View {
        Button {
            emojis = Array(
                theme.emojis
                    .shuffled()[
                        ..<Int
                            .random(in: 2..<theme.emojis.count)
                    ]
            )
            
            color = theme.color
        } label: {
            VStack {
                Image(systemName: theme.image)
                    .font(.largeTitle)
                Text(theme.title)
            }
            .foregroundColor(theme.color)
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
    @State var isFaceUp = false
    
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
