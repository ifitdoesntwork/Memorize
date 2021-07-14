//
//  ContentView.swift
//  Memorize
//
//  Created by Denis Avdeev on 11.07.2021.
//

import SwiftUI

struct ContentView: View {
    struct Theme {
        let emojis: [String]
        let iconName: String
        
        var shuffledEmojis: [String] {
            emojis.shuffled()
        }
        
        func fullIconName(selectedEmojis: [String]) -> String {
            
            let selectionSuffix = emojis.sorted() == selectedEmojis.sorted()
                ? ".fill"
                : ""
            
            return iconName + selectionSuffix
        }
    }
    
    static let themes = [
        Theme(
            emojis: ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"],
            iconName: "car"
        ),
        Theme(
            emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"],
            iconName: "hare"
        ),
        Theme(
            emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🎱", "🏸", "⛷", "🧘‍♀️", "🏄‍♀️", "🏊‍♀️", "🚴‍♀️"],
            iconName: "sportscourt"
        )
    ]
    
    @State var emojis = themes[0].shuffledEmojis
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(emojis, id: \.self ) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
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
        HStack {
            Spacer()
            
            ForEach(Self.themes, id: \.iconName) { theme in
                Button {
                    emojis = theme.shuffledEmojis
                } label: {
                    Image(
                        systemName: theme
                            .fullIconName(selectedEmojis: emojis)
                    )
                }
                
                Spacer()
            }
        }
        .font(.largeTitle)
        .padding()
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape
                    .fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
