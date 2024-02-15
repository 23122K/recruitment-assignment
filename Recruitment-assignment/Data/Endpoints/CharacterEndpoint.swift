//
//  CharacterEndpoint.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

extension API.Endpoints {
    enum CharacterEndpoint {
        case all
        case specific(id: Character.ID)
        case search(query: Query, phrase: String)
    }
}

extension API.Endpoints.CharacterEndpoint {
    enum Query: String {
        case name
        case status
        case species
        case type
        case gender
    }
}

extension API.Endpoints.CharacterEndpoint: Endpoint {
    var method: HTTPMethod {
        switch self {
        case .all:      HTTPMethod.get
        case .specific: HTTPMethod.get
        case .search:   HTTPMethod.get
        }
    }
    
    var headers: [String : String]  { API.Endpoints.headers }
    var queries: [String : String]? {
        switch self {
        case let .search(query, phrase): [query.rawValue:phrase]
        default: nil
        }
    }
    
    var schema: String  { API.Endpoints.schema }
    var port: Int       { API.Endpoints.port }
    var host: String    { API.Endpoints.host }
    var version: String { API.Endpoints.version}
    
    var path: String    {
        switch self {
        case .all, .search:     "character"
        case let .specific(id): "character/\(id)"
        }
    }
}
