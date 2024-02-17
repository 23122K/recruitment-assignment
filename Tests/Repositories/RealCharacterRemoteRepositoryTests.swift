//
//  RealCharacterRemoteRepositoryTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import XCTest

final class RealCharacterRemoteRepositoryTests: XCTestCase {
    var sut: RealCharacterRemoteRepository = RealCharacterRemoteRepository(session: .mock)
    
    override func tearDown() { MockURLProtocol.removeAllMockedResponses() }
    
    func test_CharacterRemoteRepository_getAllMethod_validRequest_shouldReturnResults() async throws {
        //Arrange
        let expectedInfo = API.Character.Mock.valid.info
        let expectedResults = API.Character.Mock.valid.results
        
        let _url = API.Endpoints.CharacterEndpoint.all.url
        let _response = HTTPURLResponse(url: _url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let _mocked = MockResponse(url: _url, data: API.Character.JSON.valid, response: _response)
    
        //Act
        MockURLProtocol.add(response: _mocked)
        let response = try await sut.getAll()
        let info = response.info
        let results = response.results
        
        //Assert
        XCTAssertEqual(results.first?.name, expectedResults.first?.name)
        XCTAssertEqual(results.last?.episodes, expectedResults.last?.episodes)
        XCTAssertEqual(results, results)
        XCTAssertEqual(info, info)
    }
    
    func test_CharacterRemoteRepository_getAllMethod_invalidRequest_shouldThrowError() async throws {
        //Arrange
//        let expectedErrorDescription = Character.Decoded.error.description
//        let expectedError = RemoteRepositoryError.invalidRequest
        
        let _url = API.Endpoints.CharacterEndpoint.all.url
        let _response = HTTPURLResponse(url: _url, statusCode: 404, httpVersion: nil, headerFields: nil)
        let _mocked = MockResponse(url: _url, data: API.Character.JSON.error, response: _response)
        
        //Act
        MockURLProtocol.add(response: _mocked)
    }
}
