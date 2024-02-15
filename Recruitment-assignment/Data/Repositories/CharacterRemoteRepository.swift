//
//  CharacterRemoteRepository.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

class CharacterRemoteRepository: RemoteRepository {
    var session: URLSession
    
    func getAll() async throws -> API.Response<Character> {
        let endpoint = API.Endpoints.CharacterEndpoint.all
        return try await data(for: endpoint.request).decode(to: API.Response.self)
    }
    
    func getCharacter(with id: Character.ID)  async throws -> Character {
        let endpoint = API.Endpoints.CharacterEndpoint.specific(id: id)
        return try await data(for: endpoint.request).decode(to: Character.self)
    }
    
    func searchCharacters(for query: API.Endpoints.CharacterEndpoint.Query, with phrase: String) async throws -> API.Response<Character> {
        let endpoint = API.Endpoints.CharacterEndpoint.search(query: query, phrase: phrase)
        return try await data(for: endpoint.request).decode(to: API.Response.self)
    }
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}
