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
        NavigationStack {
            VStack(spacing: 0) {
                Button("Get") { vm.getAllCharactersButtonTapped() }
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
    }
    
    init(characters ids: [Character.ID]? = .none) {
        var vm: CharactersListModel
        
        switch ids {
        case let .some(ids): vm = CharactersListModel(character: ids)
        case .none: vm = CharactersListModel()
        }
        
        self._vm = ObservedObject(wrappedValue: vm)
    }
}
