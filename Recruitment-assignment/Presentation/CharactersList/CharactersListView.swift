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
            AsyncView(state: $vm.characters, placeholder: CharactersListView.Placeholder()) { characters in
                CustomList(characters) { character in
                    CharacterRowView(character: character, favorite: vm.favorite) {
                        vm.initateToggleFavorite(for: character)
                    }
                    .onTapGesture { vm.initiateDestination(to: .details(character)) }
                }
            }
        }
        .padding(5)
        .animation(.bouncy, value: vm.characters.isLoaded)
        .navigationDestination(unwrapping: $vm.destination.details) { $character in
            CharactersDetailsView(character: character)
                .title("Characters")
        }
    }
    
    init(character ids: [Character.ID]? = .none, loadable characters: Loadable<[Character]>? = nil) {
        var vm: CharactersListModel
        
        switch ids {
        case let .some(ids): vm = CharactersListModel(character: .some(ids))
        case .none: vm = CharactersListModel(loadable: characters)
        }
        
        self._vm = ObservedObject(wrappedValue: vm)
    }
}

extension CharactersListView {
    struct Placeholder: View {
        var body: some View {
            ScrollView {
                ForEach(0...Int.random(in: 4...8), id: \.self) { _ in
                    CharacterRowView.Redacted()
                }
            }
            .scrollIndicators(.never)
        }
    }
}
