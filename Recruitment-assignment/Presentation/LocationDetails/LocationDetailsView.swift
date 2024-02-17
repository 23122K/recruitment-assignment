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
            AsyncView(state: $vm.location, placeholder: LocationListView.Placeholder()) { location in
                ScrollView {
                    GenericRowView(location.name, category: "Location name", image: Image(systemName: "movieclapper"))
                    GenericRowView(location.dimension, category: "Dimension", image: Image(systemName: "bubbles.and.sparkles"))
                    GenericRowView(location.type, category: "Type", image: Image(systemName: "atom"))
                    GenericRowView(location.characters.count.description, category: "Characters count", image: Image(systemName: "person.fill"), clickable: true)
                        .onTapGesture { vm.initiadeDestination(to: .characters(location.characters)) }
                }
                .scrollIndicators(.never)
            }
        }
        .navigationDestination(unwrapping: $vm.destination.characters) { $characters in
            CharactersListView(character: characters)
                .title(vm.location.value?.name)
        }
        
    }
    
    init(location id: Location.ID) {
        self._vm = ObservedObject(wrappedValue: LocationDetailsModel(location: id))
    }
}
