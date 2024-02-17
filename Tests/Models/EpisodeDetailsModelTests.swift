//
//  EpisodeDetailsModelTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Factory
import XCTest

@MainActor
final class EpisodeDetailsModelTests: XCTestCase {
    var container: Container = .shared
    var sut: EpisodeDetailsModel!
    
    override func setUp() async throws {
        self.container.onSetUp()
        self.sut = EpisodeDetailsModel(episode: Episode.mock())
    }
    
    override func tearDown() async throws {
        self.sut = nil
        self.container.onTearDown()
    }
    
    func test_EpisodeDetailsModel_initiateDestinationMethod_shoudUpdateDestination() throws {
        let expectedInitialDestination: EpisodeDetailsModel.Destination? = .none
        var currentDestination = sut.destination
        
        XCTAssertEqual(currentDestination, expectedInitialDestination)
        
        let characters: [Character.ID] = Character.mocks().map { character in character.id }
        let expectedDestination: EpisodeDetailsModel.Destination = .characters(characters)
        
        sut.initiadeDestination(to: expectedDestination)
        currentDestination = sut.destination
        
        XCTAssertEqual(currentDestination, expectedDestination)
    }
}
