//
//  CharacterRemoteRepository.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import Foundation

protocol CharacterRemoteRepository: RemoteRepository {
    var session: URLSession { get }
    
    func getAll() async throws -> API.Response<Character>
    func getCharacter(with id: Character.ID) async throws -> Character
    func getCharacters(with ids: [Character.ID]) async throws -> [Character]
    func searchCharacters(for query: API.Endpoints.CharacterEndpoint.Query, with phrase: String) async throws -> API.Response<Character>
}
