//
//  MockURLProtocol.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import Foundation

final class MockURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }
    
    override func startLoading() {
        if let mock = MockURLProtocol.fetch(for: request) {
            
            if let responseStrong = mock.response {
                self.client?.urlProtocol(self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
            }
            
            if let dataStrong = mock.data {
                self.client?.urlProtocol(self, didLoad: dataStrong)
            }
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}

extension MockURLProtocol {
    static var mockedResponses: [MockResponse] = []
    
    static func add(response: MockResponse) {
        mockedResponses.append(response)
    }
    
    static func removeAllMockedResponses() {
        mockedResponses.removeAll()
    }
    
    static func fetch(for request: URLRequest) -> MockResponse? {
        mockedResponses.first { response in
            response.url == request.url
        }
    }
}

struct MockResponse {
    let url: URL
    let data: Data?
    let response: URLResponse?
}
