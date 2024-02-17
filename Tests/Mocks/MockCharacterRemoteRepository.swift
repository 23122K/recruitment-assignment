//
//  MockCharacterRemoteRepository.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Foundation

class MockCharacterRemoteRepository: CharacterRemoteRepository {
    var session: URLSession
    
    func getAll() async throws -> API.Response<Character> {
        return API.Character.Mock.valid
    }
    
    func getCharacter(with id: Character.ID) async throws -> Character {
        return Character.mock(id: id)
    }
    
    func getCharacters(with ids: [Character.ID]) async throws -> [Character] {
        return Character.mocks(ids: ids)
    }
    
    func searchCharacters(for query: API.Endpoints.CharacterEndpoint.Query, with phrase: String) async throws -> API.Response<Character> {
        return API.Character.Mock.valid
    }
    
    init(session: URLSession = URLSession.mock) {
        self.session = session
    }
}
