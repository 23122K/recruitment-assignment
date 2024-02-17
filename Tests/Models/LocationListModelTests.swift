//
//  LocationListModelTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Factory
import XCTest

@MainActor
final class LocationListModelTests: XCTestCase {
    var container: Container = .shared
    var sut: LocationListModel!
    
    override func setUp() async throws {
        self.container.onSetUp()
        self.sut = LocationListModel()
    }
    
    override func tearDown() async throws {
        self.sut = nil
        self.container.onTearDown()
    }
    
    func test_LocationListModel_initiateDestinationMethod_shoudUpdateDestination() throws {
        let expectedInitialDestination: LocationListModel.Destination? = .none
        var currentDestination = sut.destination
        
        XCTAssertEqual(currentDestination, expectedInitialDestination)
        
        let location: Location = .mock()
        let expectedDestination: LocationListModel.Destination = .details(location)
        
        sut.initateDestination(to: expectedDestination)
        currentDestination = sut.destination
        
        XCTAssertEqual(currentDestination, expectedDestination)
    }
}
