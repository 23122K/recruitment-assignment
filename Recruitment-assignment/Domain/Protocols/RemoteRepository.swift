//
//  RemoteRepository.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

enum RemoteRepositoryError: Error, LocalizedError, Comparable {
    static func < (lhs: RemoteRepositoryError, rhs: RemoteRepositoryError) -> Bool {
        lhs.localizedDescription < rhs.localizedDescription
    }
    
    case invalidResponse
    case invalidStatusCode(code: Int, data: Data)
    case invalidRequest(_ description: String)
    case noInternetConnection
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse: String(localized: "Invalid response")
        case let .invalidStatusCode(code, _): String(localized: "Status code \(code)")
        case let .invalidRequest(description): String(localized: "\(description)")
        case .noInternetConnection: String(localized: "No internet connection")
        }
    }
}


protocol RemoteRepository {
    var session: URLSession { get }
}

extension RemoteRepository {
    func data(for request: URLRequest) async throws -> Data {
        let task = Task<Data, Error> {
            guard let (data, response) = try await session.data(for: request) as? (Data, HTTPURLResponse) else {
                throw RemoteRepositoryError.invalidResponse
            }
            
            guard (200...299).contains(response.statusCode) else {
                throw RemoteRepositoryError.invalidStatusCode(code: response.statusCode, data: data)
            }
            
            return data
        }
        
        return try await task.value
    }
    
    func handle(_ `func`: @escaping () async throws -> Data) async rethrows -> Data {
        do { return try await `func`() }
        catch RemoteRepositoryError.invalidStatusCode(_, let data) {
            let error = try data.decode(to: API.Error.self)
            throw RemoteRepositoryError.invalidRequest(error.description)
        } catch { throw error }
    }

}
