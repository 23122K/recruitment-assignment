//
//  SearchListModel.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import Factory
import Foundation
import SwiftUI
import SwiftUINavigation

@MainActor
class SearchModel: ObservableObject {
    @Published var characters: Loadable<[Character]>
    @Published var locations: Loadable<[Location]>
    @Published var episodes: Loadable<[Episode]>
    @Published var destination: Destination?
    
    @Published var filters: [Filter]
    @Published var filter: Filter
    @Published var phrase: String
    
    @Injected(\.characterRemoteRepository) private var characterRemoteRepository
    @Injected(\.locationRemoteRepository) private var locationRemoteRepository
    @Injected(\.episodeRemoteRepository) private var episodeRemoteRepository
    @Injected(\.subscrptions) private var subscrptions

    @CasePathable
    enum Field {
        case search
    }
    
    @CasePathable
    enum Destination {
        case character(_ character: Character)
        case location(_ location: Location)
        case episode(_ episode: Episode)
    }
    
    func initateDestination(to destination: Destination) {
        self.destination = destination
    }
    
    func initateUpdateFilters(for filter: Filter) {
        self.filter = filter
    }
    
    private func initiateSearch(for phrase: String) {
        if phrase.isEmpty { return }
        
        switch filter {
        case let .character(query): initiateFilterCharacters(phrase: phrase, with: query)
        case let .location(query):  initiateFilterLocations(phrase: phrase, with: query)
        case let .episode(query):   initiateFilterEpisodes(phrase: phrase, with: query)
        }
    }
    
    private func initiateFilterCharacters(phrase: String, with query: API.Endpoints.CharacterEndpoint.Query) {
        Task(priority: .userInitiated) {
            do {
                self.characters = .loading
                let response = try await characterRemoteRepository.searchCharacters(for: query, with: phrase)
                self.characters = .loaded(response.results)
            } catch { self.characters = .failed(error) }
        }
    }
    
    private func initiateFilterLocations(phrase: String, with query: API.Endpoints.LocationEndpoint.Query) {
        Task(priority: .userInitiated) {
            do {
                self.locations = .loading
                let response = try await locationRemoteRepository.searchLocations(for: query, with: phrase)
                self.locations = .loaded(response.results)
            } catch { self.locations = .failed(error) }
        }
    }
    
    private func initiateFilterEpisodes(phrase: String, with query: API.Endpoints.EpisodeEndpoint.Query) {
        Task(priority: .userInitiated) {
            do {
                self.episodes = .loading
                let response = try await episodeRemoteRepository.searchEpisodes(for: query, with: phrase)
                self.episodes = .loaded(response.results)
            } catch { self.episodes = .failed(error) }
        }
    }
    
    init(characters: Loadable<[Character]> = .none,
         locations: Loadable<[Location]> = .none,
         episodes: Loadable<[Episode]> = .none,
         destination: Destination? = .none,
         filters: [Filter] = [.character(.name), .episode(.name), .location(.name)],
         filter: Filter = .character(.name),
         phrase: String = String()
    ) {
        self.characters = characters
        self.locations = locations
        self.episodes = episodes
        self.destination = destination
        self.filters = filters
        self.filter = filter
        self.phrase = phrase
        
        $phrase
            .removeDuplicates()
            .debounce(for: .milliseconds(333), scheduler: RunLoop.main)
            .sink { [weak self] phrase in
                self?.phrase = phrase
                self?.initiateSearch(for: phrase)
            }
            .store(in: &subscrptions.cancelbag)
    }
}

extension SearchModel {
    enum Filter: Identifiable, CustomStringConvertible {
        case character(_ query: API.Endpoints.CharacterEndpoint.Query)
        case location(_ query: API.Endpoints.LocationEndpoint.Query)
        case episode(_ quiery: API.Endpoints.EpisodeEndpoint.Query)
        
        var id: String { self.description }
        
        var description: String {
            switch self {
            case .character: "Character"
            case .location: "Location"
            case .episode: "Episode"
            }
        }
    }
}
