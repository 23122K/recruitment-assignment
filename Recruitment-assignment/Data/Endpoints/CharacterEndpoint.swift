//
//  CharacterEndpoint.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

extension Endpoints {
    enum CharacterEndpoint {
        case all
        case specific(character: Character)
        case multiple(characters: [Character])
    }
}

extension Endpoints.CharacterEndpoint: Endpoint {
    var method: HTTPMethod {
        switch self {
        case .all:      HTTPMethod.get
        case .specific: HTTPMethod.get
        case .multiple: HTTPMethod.get
        }
    }
    
    var queries: [String : String]? { return nil }
    var headers: [String : String]  { Endpoints.headers }
    
    var schema: String  { Endpoints.schema }
    var port: Int       { Endpoints.port }
    var host: String    { Endpoints.host }
    var version: String { Endpoints.version}
    
    var path: String    {
        switch self {
        case .all:                      "character"
        case let .specific(character):  "character/\(character.id)"
        case let .multiple(characters): "character/\(characters.first?.id)" //TODO: Extract ids from objeect and interpolate them as a single string
        }
    }
}
