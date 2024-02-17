//
//  URLSession+Extension.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import Foundation

extension URLSession {
    static var mock: URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        configuration.timeoutIntervalForResource = 1
        configuration.timeoutIntervalForRequest = 1
        return URLSession(configuration: configuration)
    }
}
