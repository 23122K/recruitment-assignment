//
//  EpisodeRemoteRepository.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

class RealEpisodeRemoteRepository: EpisodeRemoteRepository {
    var session: URLSession
    
    func getAll() async throws -> API.Response<Episode> {
        let endpoint = API.Endpoints.EpisodeEndpoint.all
        return try await handle { try await self.data(for: endpoint.request) }
            .decode(to: API.Response.self)
    }
    
    func getEpisode(with id: Episode.ID) async throws -> Episode {
        let endpoint = API.Endpoints.EpisodeEndpoint.specific(id: id)
        return try await handle { try await self.data(for: endpoint.request) }
            .decode(to: Episode.self)
    }
    
    func getEpisodes(with ids: [Episode.ID]) async throws -> [Episode] {
        let endpoint = API.Endpoints.EpisodeEndpoint.multiple(ids: ids)
        return try await handle { try await self.data(for: endpoint.request) }
            .decode(to: [Episode].self)
    }
    
    func searchEpisodes(for query: API.Endpoints.EpisodeEndpoint.Query, with phrase: String) async throws -> API.Response<Episode> {
        let endpoint = API.Endpoints.EpisodeEndpoint.search(query: query, phrase: phrase)
        return try await handle { try await self.data(for: endpoint.request) }
            .decode(to: API.Response.self)
    }
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}
