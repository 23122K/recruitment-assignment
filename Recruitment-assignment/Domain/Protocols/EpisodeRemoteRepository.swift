//
//  EpisodeRemoteRepository.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import Foundation

protocol EpisodeRemoteRepository: RemoteRepository {
    var session: URLSession { get }
    
    func getAll() async throws -> API.Response<Episode>
    func getEpisode(with id: Episode.ID) async throws -> Episode
    func getEpisodes(with ids: [Episode.ID]) async throws -> [Episode]
    func searchEpisodes(for query: API.Endpoints.EpisodeEndpoint.Query, with phrase: String) async throws -> API.Response<Episode>
}
