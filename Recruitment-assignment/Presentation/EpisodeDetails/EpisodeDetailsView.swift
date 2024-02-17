//
//  EpisodeDetailsView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import SwiftUI
import SwiftUINavigation

struct EpisodeDetailsView: View {
    @ObservedObject private var vm: EpisodeDetailsModel
    
    var body: some View {
        VStack {
            ScrollView {
                GenericRowView(vm.episode.name, category: "Episode title", image: Image(systemName: "movieclapper"))
                GenericRowView(vm.episode.aired, category: "First aired", image: Image(systemName: "antenna.radiowaves.left.and.right"))
                HStack(spacing: 0) {
                    GenericRowView(vm.episode.number.description, category: "Episode no.", image: Image(systemName: "number"))
                    Spacer()
                    GenericRowView(vm.episode.season.description, category: "Season", image: Image(systemName: "number"))
                }
                GenericRowView(vm.episode.characters.count.description, category: "Characters count", image: Image(systemName: "person.fill"), clickable: true)
                    .onTapGesture { vm.initiadeDestination(to: .characters(vm.episode.characters)) }
            }
            .scrollIndicators(.never)
        }
        .padding(5)
        .navigationDestination(unwrapping: $vm.destination.characters) { $characters in
            CharactersListView(character: characters)
                .title(vm.episode.name)
        }
        
    }
    
    init(_ episode: Episode) {
        self._vm = ObservedObject(wrappedValue: EpisodeDetailsModel(episode: episode))
    }
}
