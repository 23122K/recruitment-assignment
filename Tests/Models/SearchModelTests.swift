//
//  SearchModelTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Factory
import XCTest

@MainActor
final class SearchModelTests: XCTestCase {
    var container: Container = .shared
    var sut: SearchModel!
    
    override func setUp() async throws {
        self.container.onSetUp()
        self.sut = SearchModel()
    }
    
    override func tearDown() async throws {
        self.sut = nil
        self.container.onTearDown()
    }

    func test_SearchModel_initiateDestinationMethod_shoudUpdateDestination() throws {
        let character: Character = .mock()
        let location: Location = .mock()
        let episode: Episode = .mock()
        
        let expectedInitialDestination: SearchModel.Destination? = .none
        var currentDestination = sut.destination
        
        XCTAssertEqual(currentDestination, expectedInitialDestination)
        
        let expectedCharacterDestination: SearchModel.Destination = .character(character)
        let expectedLocationDestination: SearchModel.Destination = .location(location)
        let expectedEpisodeDestination: SearchModel.Destination = .episode(episode)
        
        sut.initateDestination(to: expectedCharacterDestination)
        currentDestination = sut.destination
        XCTAssertEqual(currentDestination, expectedCharacterDestination)
        
        sut.initateDestination(to: expectedLocationDestination)
        currentDestination = sut.destination
        XCTAssertEqual(currentDestination, expectedLocationDestination)
        
        sut.initateDestination(to: expectedEpisodeDestination)
        currentDestination = sut.destination
        XCTAssertEqual(currentDestination, expectedEpisodeDestination)
        
    }
    
    func test_SearchModel_initateUpdateFilter_shouldUpdateFilter() async throws {
        let expectedCharacterFilter: SearchModel.Filter = .character(.status)
        let expectedLocationFilter: SearchModel.Filter = .location(.dimension)
        let expectedEpisodeFilter: SearchModel.Filter = .episode(.name)
        
        var currentFilter = sut.filter
        
        XCTAssertEqual(currentFilter, .character(.name))
        
        sut.initateUpdateFilters(for: expectedCharacterFilter)
        currentFilter = sut.filter
        XCTAssertEqual(currentFilter, expectedCharacterFilter)
        
        sut.initateUpdateFilters(for: expectedLocationFilter)
        currentFilter = sut.filter
        XCTAssertEqual(currentFilter, expectedLocationFilter)
        
        sut.initateUpdateFilters(for: expectedEpisodeFilter)
        currentFilter = sut.filter
        XCTAssertEqual(currentFilter, expectedEpisodeFilter)
    }
    
    func test_SearchModel_initiateSearch_validPhrase_shouldBeEmpty() async throws {
        let expectedInitialPhrase: String = .init()
        let expectedInitialFiliter: SearchModel.Filter = .character(.name)
        
        let currentPhrase = sut.phrase
        let currentFilter = sut.filter
        
        XCTAssertEqual(currentPhrase, expectedInitialPhrase)
        XCTAssertEqual(currentFilter, expectedInitialFiliter)
    }
    
    func test_SearchModel_initiateFilterCharacters_validPhrase_shouldUpdateFilters() async throws {
        let expectedQuery: API.Endpoints.CharacterEndpoint.Query = .name
        let expectedPhrase: String = .init()
        let currentPhrase = sut.phrase
        
        XCTAssertEqual(currentPhrase, expectedPhrase)
        await sut.initiateFilterCharacters(phrase: expectedPhrase, with: expectedQuery)
        XCTAssertNotNil(sut.characters.value)
    }
    
    func test_SearchModel_initiateFilterLocations_shouldUpdateFilters() async throws {
        let expectedQuery: API.Endpoints.LocationEndpoint.Query = .dimension
        let expectedPhrase: String = .init()
        let currentPhrase = sut.phrase
        
        XCTAssertEqual(currentPhrase, expectedPhrase)
        await sut.initiateFilterLocations(phrase: expectedPhrase, with: expectedQuery)
        XCTAssertNotNil(sut.locations.value)
    }
    
    func test_SearchModel_initiateFilterEpisodes_shouldUpdateFilters() async throws {
        let expectedQuery: API.Endpoints.EpisodeEndpoint.Query = .name
        let expectedPhrase: String = .init()
        let currentPhrase = sut.phrase
        
        XCTAssertEqual(currentPhrase, expectedPhrase)
        await sut.initiateFilterEpisodes(phrase: expectedPhrase, with: expectedQuery)
        XCTAssertNotNil(sut.episodes.value)
    }
}
