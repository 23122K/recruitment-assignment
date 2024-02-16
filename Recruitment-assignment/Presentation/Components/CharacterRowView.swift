//
//  CharacterRowView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI
import Shimmer

struct CharacterRowView: View {
    @State private var value: Bool = false
    private let gradient = Gradient(colors: [Color.clear, Color.secondary.opacity(0.5)])
    let character: Character
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: character.image) { phase in
                switch phase {
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65, height: 65)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
                        .onAppear { value.toggle() }
                        .animation(.easeIn, value: value)
                case .empty, .failure: Redacted.asyncImagePlaceholder()
                @unknown default: Redacted.asyncImagePlaceholder()
                }
            }
            .animation(.smooth, value: value)
            
            VStack(alignment: .listRowSeparatorLeading) {
                Text(verbatim: character.name)
                    .foregroundStyle(Color.font)
                    .bold()
                
                Text("Character name")
                    .foregroundStyle(Color.font)
                    .font(.caption)
            }
            .padding(.horizontal)
                
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.secondary)
        }
    }
}

extension CharacterRowView {
    struct Redacted: View {
        var body: some View {
            HStack(alignment: .center) {
                Redacted.asyncImagePlaceholder()
                
                VStack(alignment: .listRowSeparatorLeading) {
                    Text(verbatim: String.random(in: 15..<30))
                        .foregroundStyle(Color.font)
                        .bold()
                    
                    Text(String.random(in: 14..<20))
                        .foregroundStyle(Color.font)
                        .font(.caption)
                }
                .padding(.horizontal)
                .redacted(reason: .placeholder)
                    
                Spacer()
            }
            .redacted(reason: .placeholder)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.secondary)
            }
            .shimmering()
        }
    }
}

extension CharacterRowView.Redacted {
    @ViewBuilder
    static func asyncImagePlaceholder() -> some View {
        Color.font
            .frame(width: 65, height: 65)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .redacted(reason: .placeholder)
            .shimmering()
    }
}
