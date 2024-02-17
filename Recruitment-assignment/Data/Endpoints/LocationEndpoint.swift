//
//  LocationEndpoint.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

extension API.Endpoints {
    enum LocationEndpoint {
        case all
        case specific(id: Location.ID)
        case search(query: Query, phrase: String)
    }
}

extension API.Endpoints.LocationEndpoint {
    enum Query: String {
        case name
        case type
        case dimension
    }
}

extension API.Endpoints.LocationEndpoint: Endpoint {
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
        case let .search(query, phrase): [query.rawValue: phrase]
        default: nil
        }
    }
    
    var schema: String  { API.Endpoints.schema }
    var port: Int       { API.Endpoints.port }
    var host: String    { API.Endpoints.host }
    var version: String { API.Endpoints.version}
    
    var path: String    {
        switch self {
        case .all, .search:     "location"
        case let .specific(id): "location/\(id)"
        }
    }
}
