//
//  MockEndpoint.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//


@testable
import Recruitment_assignment
import Foundation

enum MockEndpoint {
    case create
    case fetch
    case update
    case delete(Int)
}

extension MockEndpoint: Endpoint {
    var method: Recruitment_assignment.HTTPMethod {
        switch self {
        case .create:   Recruitment_assignment.HTTPMethod.post
        case .fetch:    Recruitment_assignment.HTTPMethod.get
        case .update:   Recruitment_assignment.HTTPMethod.put
        case .delete:   Recruitment_assignment.HTTPMethod.delete
        }
    }
    
    var queries: [String : String]? {
        switch self {
        case let .delete(id): [Settings.query:id.description]
        default: nil
        }
    }
    
    var headers: [String : String] { Settings.headers }
    var schema: String { Settings.schema }
    var port: Int { Settings.port }
    var host: String { Settings.host }
    var version: String { Settings.version }
    
    var path: String { Settings.path }
}

extension MockEndpoint {
    struct Settings {
        static let query = "mock"
        static let headers = [
            "accept" : "*/*",
            "mock": "true"
        ]
        static let schema = "http"
        static let port = 1024
        static let host = "127.0.0.1"
        static let version = "api"
        static let path = "mock"
    }
}
