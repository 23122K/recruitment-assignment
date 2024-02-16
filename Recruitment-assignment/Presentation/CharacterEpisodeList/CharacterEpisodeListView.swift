//
//  CharacterEpisodeListView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI
import SwiftUINavigation

struct CharacterEpisodeListView: View {
    @ObservedObject var vm: CharacterEpisodeListModel
    
    var body: some View {
        AsyncView(state: $vm.episodes) { episodes in
            ScrollView {
                ForEach(episodes) { episode in
                    EpisodeRowView(episode.name, number: episode.number, season: episode.season, image: Image(systemName: "movieclapper"))
                        .onTapGesture { vm.initateDestination(to: .details(episode)) }
                }
            }
            .scrollIndicators(.never)
        }
        .navigationDestination(unwrapping: $vm.destination.details) { $episode in
            EpisodeDetailsView(episode)
                .title(vm.character.name)
        }
        
    }
    
    init(_ character: Character) {
        self._vm = ObservedObject(initialValue: CharacterEpisodeListModel(character: character))
    }
}
