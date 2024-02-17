//
//  LocationDetailsModelTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Factory
import XCTest

@MainActor
final class LocationDetailsModelTests: XCTestCase {
    var container: Container = .shared
    var sut: LocationDetailsModel!
    
    override func setUp() async throws {
        self.container.onSetUp()
        self.sut = LocationDetailsModel(location: Location.mock().id)
    }
    
    override func tearDown() async throws {
        self.sut = nil
        self.container.onTearDown()
    }
    
    func test_LocationDetailsModel_initateGetLocationMethod_shouldSetLoadable() async throws {
        let location: Location = .mock()
        await sut.initateGetLocation(location: location.id)
        
        XCTAssertNotNil(sut.location)
    }
    
    func test_LocationDetailsModel_initiateDestinationMethod_shoudUpdateDestination() throws {
        let expectedInitialDestination: LocationDetailsModel.Destination? = .none
        var currentDestination = sut.destination
        
        XCTAssertEqual(currentDestination, expectedInitialDestination)
        
        let characters: [Character.ID] = Character.mocks().map { character in character.id }
        let expectedDestination: LocationDetailsModel.Destination = .characters(characters)
        
        sut.initiadeDestination(to: expectedDestination)
        currentDestination = sut.destination
        
        XCTAssertEqual(currentDestination, expectedDestination)
    }
}
