//
//  CharacterHeaderView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI
import Shimmer

struct CharacterHeaderView: View {
    private let gradient = Gradient(colors: [Color.clear, Color.primary])
    
    let character: Character
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: character.image) { phase in
                switch phase {
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFit()
                        .overlay(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                case .empty, .failure: Self.asyncImagePlaceholder()
                @unknown default: Self.asyncImagePlaceholder()
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

extension CharacterHeaderView {
    @ViewBuilder
    static func asyncImagePlaceholder() -> some View {
        Color.font
        Color.primary
            .frame(width: 400, height: 400)
            .redacted(reason: .placeholder)
            .shimmering()
    }
}

