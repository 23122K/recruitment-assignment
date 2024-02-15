//
//  Endpoints.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

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
