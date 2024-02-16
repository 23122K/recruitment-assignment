//
//  CharactersListView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import SwiftUI
import SwiftUINavigation

struct CharactersListView: View {
    @ObservedObject var vm: CharactersListModel
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncView(state: $vm.characters) { characters in
                ScrollView {
                    ForEach(characters) { character in
                        CharacterRowView(character: character)
                            .onTapGesture { vm.initiateDestination(to: .details(character)) }
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .navigationDestination(unwrapping: $vm.destination.details) { $character in
            CharactersDetailsView(character: character)
                .title("Characters")
        }
    }
    
    init(character ids: [Character.ID]? = .none, loadable characters: Loadable<[Character]> = .none) {
        var vm: CharactersListModel
        
        switch ids {
        case let .some(ids): vm = CharactersListModel(character: .some(ids), characters: characters)
        case .none: vm = CharactersListModel(character: .none, characters: characters)
        }
        
        self._vm = ObservedObject(wrappedValue: vm)
    }
}
