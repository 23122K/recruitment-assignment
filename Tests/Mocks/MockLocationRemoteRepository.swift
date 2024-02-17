//
//  MockLocationRemoteRepository.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Foundation

class MockLocationRemoteRepository: LocationRemoteRepository {
    var session: URLSession
    
    func getAll() async throws -> API.Response<Location> {
        return API.Location.Mock.valid
    }
    
    func getLocation(with id: Location.ID)  async throws -> Location {
        return Location.mock(id: id)
    }
    
    func searchLocations(for query: API.Endpoints.LocationEndpoint.Query, with phrase: String) async throws -> API.Response<Location> {
        return API.Location.Mock.valid
    }
    
    init(session: URLSession = URLSession.mock) {
        self.session = session
    }
}
