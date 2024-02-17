//
//  EpisodeListModelTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Factory
import XCTest

@MainActor
final class EpisodeListModelTests: XCTestCase {
    var container: Container = .shared
    var sut: EpisodeListModel!
    
    override func setUp() async throws {
        self.container.onSetUp()
        self.sut = EpisodeListModel(character: nil)
    }
    
    override func tearDown() async throws {
        self.sut = nil
        self.container.onTearDown()
    }
    
    func test_EpisodeListModel_initateGetAllEpisodesWithGivenCharacter_characterExists_shouldSetLoadable() async throws {
        let character: Character = .mock()
        let _sut: EpisodeListModel = EpisodeListModel(character: character)
        
        await _sut.initateGetAllEpisodesWithGivenCharacter()
        XCTAssertNotNil(_sut.episodes.value)
    }
    
    func test_EpisodeListModel_initateGetAllEpisodesWithGivenCharacter_characterisMissing_shouldNotSetLoadable() async throws {
        let character: Character? = .none
        let _sut: EpisodeListModel = EpisodeListModel(character: character)
        
        await _sut.initateGetAllEpisodesWithGivenCharacter()
        XCTAssertNil(_sut.episodes.value)
    }
    
    func test_EpisodeListModel_initateGetAllEpisodes_shouldSetLoadable() async throws {
        await sut.initateGetAllEpisodes()
        XCTAssertNotNil(sut.episodes.value)
    }

    func test_EpisodeListModel_initiateDestinationMethod_shoudUpdateDestination() throws {
        let expectedInitialDestination: EpisodeListModel.Destination? = .none
        var currentDestination = sut.destination
        
        XCTAssertEqual(currentDestination, expectedInitialDestination)
        
        let episode: Episode = .mock()
        let expectedDestination: EpisodeListModel.Destination = .details(episode)
        
        sut.initateDestination(to: expectedDestination)
        currentDestination = sut.destination
        
        XCTAssertEqual(currentDestination, expectedDestination)
    }
}
