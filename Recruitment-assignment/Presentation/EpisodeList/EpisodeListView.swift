//
//  CharacterEpisodeListView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI
import SwiftUINavigation

struct EpisodeListView: View {
    @ObservedObject var vm: EpisodeListModel
    
    var body: some View {
        AsyncView(state: $vm.episodes, placeholder: EpisodeListView.Placeholder()) { episodes in
            ScrollView {
                ForEach(episodes) { episode in
                    EpisodeRowView(episode.name, number: episode.number, season: episode.season, image: Image(systemName: "movieclapper"))
                        .onTapGesture { vm.initateDestination(to: .details(episode)) }
                }
            }
            .scrollIndicators(.never)
        }
        .animation(.bouncy, value: vm.episodes.isLoaded)
        .navigationDestination(unwrapping: $vm.destination.details) { $episode in
            EpisodeDetailsView(episode)
                .title(vm.character?.name ?? "Search")
        }
        
    }
    
    init(_ character: Character? = nil, loadable episodes: Loadable<[Episode]>? = nil) {
        self._vm = ObservedObject(initialValue: EpisodeListModel(character: character, episodes: episodes))
    }
}

extension EpisodeListView {
    struct Placeholder: View {
        var body: some View {
            ScrollView {
                ForEach(0...Int.random(in: 3...8), id: \.self) { _ in
                    GenericRowView.Redacted()
                }
            }
            .scrollIndicators(.never)
        }
    }
}
