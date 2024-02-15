//
//  EpisodeEndpoint.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

extension Endpoints {
    enum EpisodeEndpoint {
        case all
        case specific(episode: Episode)
        case multiple(episode: [Episode])
    }
}

extension Endpoints.EpisodeEndpoint: Endpoint {
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
        case .all:                      "episode"
        case let .specific(episode):    "episode/\(episode.id)"
        case let .multiple(episode):    "episode/\(episode.first?.id)" //TODO: Extract ids from objeect and interpolate them as a single string
        }
    }
}
