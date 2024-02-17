//
//  CharactersListModelTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Factory
import XCTest

@MainActor
final class CharactersListModelTests: XCTestCase {
    var container: Container = .shared
    var sut: CharactersListModel!
    
    override func setUp() async throws {
        self.container.onSetUp()
        self.sut = CharactersListModel()
    }
    
    override func tearDown() async throws {
        self.sut = nil
        self.container.onTearDown()
    }

    func test_CharacterListModel_initiateDestinatinoMethod_shoudUpdateDestination() async throws {
        //Arrange
        let character: Character = .mock()
        
        let initialDestination: CharactersListModel.Destination? = .none
        let expectedDestination: CharactersListModel.Destination? = .details(character)
        let finalDestination: CharactersListModel.Destination? = .none
        
        //Assert
        XCTAssertEqual(sut.destination, initialDestination)
        
        //Act
        sut.initiateDestination(to: .details(character))
        
        //Assert
        XCTAssertEqual(sut.destination, expectedDestination)
        
        //Act
        sut.destination = .none
        
        //Assert
        XCTAssertEqual(sut.destination, finalDestination)
    }
    
    func test_CharacterListModel_initiateFavoriteToggle_shouldModifyFavoriteArray() async throws {
        //Arrange
        let characterA: Character = .mock(id: 1)
        let characterB: Character = .mock(id: 2)
        
        let initialFavoritesCount = 0
        let expectedFavoritesCount = 2
        let finalFavoriteCount = 1
        
        //Assert
        print(sut.favorite)
        XCTAssertEqual(sut.favorite.count, initialFavoritesCount)
        
        //Act
        sut.initateToggleFavorite(for: characterA)
        sut.initateToggleFavorite(for: characterB)
        sut.initateGetAllFavoritedCharacters()
        
        //Assert
        XCTAssertEqual(sut.favorite.count, expectedFavoritesCount)
        XCTAssertTrue(sut.favorite.contains(characterA.id))
        XCTAssertTrue(sut.favorite.contains(characterB.id))
        
        //Act
        sut.initateToggleFavorite(for: characterA)
        sut.initateGetAllFavoritedCharacters()
        
        //Assert
        XCTAssertEqual(sut.favorite.count, finalFavoriteCount)
    }
    
    func test_CharacterListModel_initiateGetFavoritedCharacters_shouldReturnElements() async throws {
        //Arrange
        let favoriteCharacters: [Character] = Character.mocks(ids: [1,2,3])
        let expectedResultCount: Int = 3
        
        //Act
        favoriteCharacters.forEach { character in sut.initateToggleFavorite(for: character) }
        sut.initateGetAllFavoritedCharacters()
        
        //Assert
        XCTAssertEqual(sut.favorite.count, expectedResultCount)
    }
    
    func test_CharacterListModel_initiateGetSpecifiedCharacters_shouldReturnElements() async throws {
        //Arrange
        let ids: [Character.ID] = Character.mocks(ids: [1,2,3]).map { character in character.id }
        let expectedCount = 3

        //Act
        await sut.initiateGetCharacters(with: ids)
        
        //Assert
        let result = try XCTUnwrap(sut.characters.value)
        XCTAssertEqual(result.count, expectedCount)
    }
    
    
}
