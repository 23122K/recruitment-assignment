//
//  API.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

struct API { }

extension API {
    struct Endpoints {
        static let schema: String = "https"
        static let port: Int = 443
        static let host: String = "rickandmortyapi.com"
        static let version: String = "api"
        
        static let headers: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
    }
}

extension API {
    struct Response<T: Hashable & Decodable>: Hashable, Decodable {
        let info: Info?
        let results: [T]
    }
}

extension API.Response {
    struct Info: Hashable, Decodable {
        let count: Int
        let pages: Int
    }
}

extension API {
    struct Error: Hashable, Decodable {
        var description: String
        
        enum CodingKeys: String, CodingKey {
            case description = "error"
        }
    }
}
