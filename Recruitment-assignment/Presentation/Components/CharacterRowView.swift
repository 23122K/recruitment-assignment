//
//  CharacterRowView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI

struct CharacterRowView: View {
    @State private var value: Bool = false
    let gradient = Gradient(colors: [Color.clear, Color.secondary.opacity(0.5)])
    let character: Character
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: character.image) { phase in
                switch phase {
                case .empty, .failure:
                    Color.primary
                        .frame(width: 65, height: 65)
                        .onAppear { value.toggle() }
                        .animation(.easeOut, value: value)
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65, height: 65)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
                        .onAppear { value.toggle() }
                        .animation(.easeIn, value: value)
                }
            }
            
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
