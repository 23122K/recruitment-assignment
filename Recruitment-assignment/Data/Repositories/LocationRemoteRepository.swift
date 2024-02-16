//
//  LocationRemoteRepository.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

class LocationRemoteRepository: RemoteRepository {
    var session: URLSession
    
    func getAll() async throws -> API.Response<Location> {
        let endpoint = API.Endpoints.LocationEndpoint.all
        return try await handle { try await self.data(for: endpoint.request) }
            .decode(to: API.Response.self)
    }
    
    func getLocation(with id: Location.ID)  async throws -> Location {
        let endpoint = API.Endpoints.LocationEndpoint.specific(id: id)
        return try await handle { try await self.data(for: endpoint.request) }
            .decode(to: Location.self)
    }
    
    func searchLocations(for query: API.Endpoints.LocationEndpoint.Query, with phrase: String) async throws -> API.Response<Location> {
        let endpoint = API.Endpoints.LocationEndpoint.search(query: query, phrase: phrase)
        return try await handle { try await self.data(for: endpoint.request) }
            .decode(to: API.Response.self)
    }
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}
