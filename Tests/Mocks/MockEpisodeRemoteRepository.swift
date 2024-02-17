//
//  MockEpisodeRemoteRepository.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Foundation

class MockEpisodeRemoteRepository: EpisodeRemoteRepository {
    var session: URLSession
    
    func getAll() async throws -> API.Response<Episode> {
        return API.Episode.Mock.valid
    }
    
    func getEpisode(with id: Episode.ID) async throws -> Episode {
        return Episode.mock(id: id)
    }
    
    func getEpisodes(with ids: [Episode.ID]) async throws -> [Episode] {
        return Episode.mocs(ids: ids)
    }
    
    func searchEpisodes(for query: API.Endpoints.EpisodeEndpoint.Query, with phrase: String) async throws -> API.Response<Episode> {
        return API.Episode.Mock.valid
    }
    
    init(session: URLSession = URLSession.mock) {
        self.session = session
    }
}
