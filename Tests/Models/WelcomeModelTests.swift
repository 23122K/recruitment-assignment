//
//  WelcomeModelTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Factory
import XCTest

@MainActor
final class WelcomeModelTests: XCTestCase {
    var container: Container = .shared
    var sut: WelcomeModel!
    
    override func setUp() async throws {
        self.container.onSetUp()
        self.sut = WelcomeModel()
    }
    
    override func tearDown() async throws {
        self.sut = nil
        self.container.onTearDown()
    }
    
    func test_WelcomeModel_initiateDestinationMethod_shoudUpdateDestination() throws {
        let expectedInitialDestination: WelcomeModel.Destination? = .none
        var currentDestination = sut.destination
        
        XCTAssertEqual(currentDestination, expectedInitialDestination)
        
        let expectedDestination: WelcomeModel.Destination = .characters
        
        sut.initateDestination(to: expectedDestination)
        currentDestination = sut.destination
        
        XCTAssertEqual(currentDestination, expectedDestination)
    }
}
