//
//  LocationDetailsView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI
import SwiftUINavigation

struct LocationDetailsView: View {
    @ObservedObject private var vm: LocationDetailsModel
    
    var body: some View {
        VStack {
            AsyncView(state: $vm.location) { location in
                ScrollView {
                    EpisodeInfoRowView(location.name, category: "Location name", image: Image(systemName: "movieclapper"))
                    EpisodeInfoRowView(location.dimension, category: "Dimension", image: Image(systemName: "bubbles.and.sparkles"))
                    if !location.type.isEmpty { EpisodeInfoRowView(location.type, category: "Type", image: Image(systemName: "atom")) }
                    EpisodeInfoRowView(location.characters.count.description, category: "Characters count", image: Image(systemName: "person.fill"), clickable: true)
                        .onTapGesture { vm.initiadeDestination(to: .characters(location.characters)) }
                }
                .scrollIndicators(.never)
            }
        }
        .navigationDestination(unwrapping: $vm.destination.characters) { $characters in
            CharactersListView(characters: characters)
                .title(vm.location.value?.name ?? "") //TODO: Fix
        }
        
    }
    
    init(_ location: Character.Location) {
        self._vm = ObservedObject(initialValue: LocationDetailsModel(location: location))
    }
}
