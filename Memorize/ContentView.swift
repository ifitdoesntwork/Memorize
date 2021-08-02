//
//  ContentView.swift
//  Memorize
//
//  Created by Denis Avdeev on 11.07.2021.
//

import SwiftUI

struct ContentView: View {
    struct Theme {
        let name: String
        let emojis: [String]
        let iconName: String
        
        var randomEmojis: [String] {
            .init(
                emojis
                    .shuffled()[
                        ..<Int.random(in: 4...emojis.count)
                    ]
            )
        }
        
        func fullIconName(selectedEmojis: [String]) -> String {
            
            let selectionSuffix = Set(emojis).isSuperset(of: selectedEmojis)
                ? ".fill"
                : ""
            
            return iconName + selectionSuffix
        }
    }
    
    static let themes = [
        Theme(
            name: "Vehicles",
            emojis: ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"],
            iconName: "car"
        ),
        Theme(
            name: "Animals",
            emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"],
            iconName: "hare"
        ),
        Theme(
            name: "Sports",
            emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🎱", "🏸", "⛷", "🧘‍♀️", "🏄‍♀️", "🏊‍♀️", "🚴‍♀️"],
            iconName: "sportscourt"
        )
    ]
    
    @State var emojis = themes[0].randomEmojis
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(
                        minimum: widthThatBestFits(cardCount: emojis.count)
                    ))
                ]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.red)
            
            Spacer()
            themeButtons
        }
        .padding(.horizontal)
    }
    
    var themeButtons: some View {
        HStack(alignment: .bottom) {
            Spacer()
            
            ForEach(Self.themes, id: \.iconName) { theme in
                Button {
                    emojis = theme.randomEmojis
                } label: {
                    VStack {
                        let iconName = theme
                            .fullIconName(selectedEmojis: emojis)
                        
                        Image(systemName: iconName)
                            .font(.largeTitle)
                        Text(theme.name)
                            .font(.body)
                    }
                }
                
                Spacer()
            }
        }
        .padding()
    }
    
    /// Optimized for iPhone Pro in portrait mode
    func widthThatBestFits(cardCount: Int) -> CGFloat {
        switch cardCount {
        case 4:
            return 120
        case 5...9:
            return 100
        case 10...16:
            return 70
        default:
            return 60
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if card.isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape
                    .opacity(0)
            } else {
                shape
                    .fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
