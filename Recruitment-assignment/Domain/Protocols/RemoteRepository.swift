//
//  RemoteRepository.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

enum RemoteRepositoryError: Error, Comparable {
    case invalidHTTPResponse
    case failedWithStatusCode(_ code: Int)
}

protocol RemoteRepository {
    var session: URLSession { get }
}

extension RemoteRepository {
    func data(for request: URLRequest) async throws -> Data {
        let task = Task<Data, Error> {
            guard let (data, response) = try await session.data(for: request) as? (Data, HTTPURLResponse) else {
                throw RemoteRepositoryError.invalidHTTPResponse
            }
            
            guard (200...299).contains(response.statusCode) else {
                throw RemoteRepositoryError.failedWithStatusCode(response.statusCode)
            }
            
            return data
        }
        
        return try await task.value
    }
}
