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
class EpisodeListModel: ObservableObject {
    @Published var character: Character?
    @Published var episodes: Loadable<[Episode]>
    @Published var destination: Destination?
    
    @Injected(\.episodeRemoteRepository) private var episodeRemoteRepository
    
    @CasePathable
    enum Destination {
        case details(_ episode: Episode)
    }
    
    func initateGetAllEpisodesWithGivenCharacter() {
        guard let character else { return }
        
        Task(priority: .userInitiated) {
            do {
                self.episodes = .loading
                let result = try await episodeRemoteRepository.getEpisodes(with: character.episodes)
                self.episodes = .loaded(result)
            } catch { self.episodes = .failed(error) }
        }
    }
    
    func initateGetAllEpisodes() {
        Task(priority: .userInitiated) {
            do {
                self.episodes = .loading
                let result = try await episodeRemoteRepository.getAll().results
                self.episodes = .loaded(result)
            } catch { self.episodes = .failed(error) }
        }
    }
    
    func initateDestination(to destination: Destination) {
        self.destination = destination
    }
    
    init(character: Character?, episodes: Loadable<[Episode]>? = Loadable<[Episode]>?.none, destination: Destination? = .none) {
        self.destination = destination
        
        switch episodes {
        case nil:
            self.episodes = .none
            switch character {
            case .none:
                self.character = .none
                self.initateGetAllEpisodes()
            case let .some(character):
                self.character = character
                self.initateGetAllEpisodesWithGivenCharacter()
            }
        case let .some(episodes):
            self.episodes = episodes
        }
    }
}
