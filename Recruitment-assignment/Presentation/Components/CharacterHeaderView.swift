//
//  CharacterHeaderView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI

struct CharacterHeaderView: View {
    @State private var value: Bool = false
    
    let gradient = Gradient(colors: [Color.clear, Color.primary])
    let character: Character
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: character.image) { phase in
                switch phase {
                case .empty, .failure:
                    Color.primary
                        .frame(width: 400, height: 400)
                        .onAppear { value.toggle() }
                        .animation(.easeOut, value: value)
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFit()
                        .overlay(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .onAppear { value.toggle() }
                        .animation(.easeIn, value: value)
                }
            }
            
            Text(character.name)
                .foregroundStyle(Color.font)
                .fontWeight(.bold)
                .font(.system(size: 40))
                .padding()
        }
        .ignoresSafeArea(.all)
    }
    
    init(_ character: Character) { self.character = character }
}
