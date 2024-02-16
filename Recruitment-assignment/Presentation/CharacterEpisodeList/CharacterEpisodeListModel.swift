//
//  CharacterEpisodeListModel.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import Factory
import Foundation
import SwiftUINavigation

@MainActor
class CharacterEpisodeListModel: ObservableObject {
    let character: Character
    
    @Published var episodes: Loadable<[Episode]> = .none
    @Published var destination: Destination? = .none
    
    @Injected(\.episodeRemoteRepository) private var episodeRemoteRepository
    
    @CasePathable
    enum Destination {
        case details(_ episode: Episode)
    }
    
    func getAllEpisodes() {
        Task(priority: .userInitiated) {
            do {
                self.episodes = .loading
                let result = try await episodeRemoteRepository.getEpisodes(with: character.episodes)
                self.episodes = .loaded(result)
            } catch { self.episodes = .failed(error) }
        }
    }
    
    func initateDestination(to destination: Destination) {
        self.destination = destination
    }
    
    init(character: Character) {
        self.character = character
        getAllEpisodes()
    }
}
