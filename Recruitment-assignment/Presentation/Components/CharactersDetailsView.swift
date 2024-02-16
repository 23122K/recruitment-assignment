//
//  CharactersDetailsView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import SwiftUI

struct CharactersDetailsView: View {
    let character: Character
    
    var body: some View {
        VStack(spacing: 0) {
            CharacterHeaderView(character)
            TabView {
                CharacterInfoView(character)
                    .padding(.horizontal, 5)
                CharacterEpisodeListView(character)
                    .padding(.horizontal, 5)
            }
            .ignoresSafeArea(.all)
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
        .background(Color.primary)
        .ignoresSafeArea(.all)
    }
}

