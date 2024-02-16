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
                EpisodeListView(character)
                    .padding(.horizontal, 5)
            }
            .ignoresSafeArea(.all)
            .tabViewStyle(.page(indexDisplayMode: .always))
            .toolbar(.hidden, for: .tabBar)
        }
        .background(Color.primary)
        .ignoresSafeArea(.all)
    }
}

