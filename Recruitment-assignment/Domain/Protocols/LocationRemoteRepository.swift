//
//  LocationRemoteRepository.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import Foundation

protocol LocationRemoteRepository: RemoteRepository {
    var session: URLSession { get }
    
    func getAll() async throws -> API.Response<Location>
    func getLocation(with id: Location.ID)  async throws -> Location
    func searchLocations(for query: API.Endpoints.LocationEndpoint.Query, with phrase: String) async throws -> API.Response<Location>
}
