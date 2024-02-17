//
//  Endpoint.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

protocol Endpoint {
    var method: HTTPMethod { get }
    
    var queries: [String: String]?  { get }
    var headers: [String: String]   { get }
    
    var schema: String  { get }
    var port: Int       { get }
    var host: String    { get }
    var version: String { get }
    
    var path: String    { get }
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = self.schema
        components.host = self.host
        components.port = self.port
        
        var url = components.url.unsafelyUnwrapped
        
        url.append(path: self.version)
        url.append(path: self.path)
        
        if let queries = queries {
            url.append(queryItems: queries.compactMap { query -> URLQueryItem in
                return URLQueryItem(name: query.key, value: query.value)
            })
        }
        
        return url
    }
    
    var request: URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = self.method.rawValue
        request.allHTTPHeaderFields = self.headers

        return request
    }
}
