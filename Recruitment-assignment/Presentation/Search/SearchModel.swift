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
    @Published var characters: Loadable<[Character]> = .none
    @Published var locations: Loadable<[Location]> = .none
    @Published var episodes: Loadable<[Episode]> = .none
    @Published var destination: Destination? = .none
    
    @Published var filters: [Filter]
    @Published var filter: Filter = .character(.name)
    @Published var phrase: String = "" {
        didSet {
            switch filter {
            case let .character(query): initiateFilterCharacters(with: query)
            case let .location(query):  initiateFilterLocations(with: query)
            case let .episode(query):   initiateFilterEpisodes(with: query)
            }
        }
    }
    
    @FocusState var focus: Field?
    
    @Injected(\.characterRemoteRepository) private var characterRemoteRepository
    @Injected(\.locationRemoteRepository) private var locationRemoteRepository
    @Injected(\.episodeRemoteRepository) private var episodeRemoteRepository
    
    enum Field: Hashable {
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
    
    func initaiteUpdateFocus(to field: Field) {
        self.focus = field
    }
    
    private func initiateFilterCharacters(with query: API.Endpoints.CharacterEndpoint.Query) {
        Task(priority: .userInitiated) {
            do {
                self.characters = .loading
                let response = try await characterRemoteRepository.searchCharacters(for: query, with: phrase)
                self.characters = .loaded(response.results)
            } catch { self.characters = .failed(error) }
        }
    }
    
    private func initiateFilterLocations(with query: API.Endpoints.LocationEndpoint.Query) {
        Task(priority: .userInitiated) {
            do {
                self.locations = .loading
                let response = try await locationRemoteRepository.searchLocations(for: query, with: phrase)
                self.locations = .loaded(response.results)
            } catch { self.locations = .failed(error) }
        }
    }
    
    private func initiateFilterEpisodes(with query: API.Endpoints.EpisodeEndpoint.Query) {
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
         phrase: String = String(),
         focus: Field? = .search
    ) {
        self.characters = characters
        self.locations = locations
        self.episodes = episodes
        self.destination = destination
        self.filters = filters
        self.filter = filter
        self.phrase = phrase
        self.focus = focus
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
