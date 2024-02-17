//
//  CharactersDetailsView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import SwiftUI

struct CharactersDetailsView: View {
    @State private var selection: Tab = .details
    let character: Character
    
    var body: some View {
        VStack(spacing: 0) {
            CharacterHeaderView(character)
            CharactersDetailsSelectedTabView(selection: $selection, character: character)
            
            TabView(selection: $selection) {
                CharacterInfoView(character)
                    .tag(Tab.details)
                    .padding(.horizontal, 5)
                EpisodeListView(character)
                    .tag(Tab.episodes)
                    .padding(.horizontal, 5)
            }
            .animation(.bouncy, value: selection)
            .ignoresSafeArea(.all)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .toolbar(.hidden, for: .tabBar)
        }
        .background(Color.primary)
        .ignoresSafeArea(.all)
    }
}

extension CharactersDetailsView {
    enum Tab: Identifiable, Hashable {
        case details
        case episodes
    
        var id: Self { self }
    }
}

