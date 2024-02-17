//
//  String+ExtensionTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import XCTest

final class String_ExtensionTests: XCTestCase {

    func test_StringExtensionParseEpisode_ValidEpisodeCode_ShouldParse() throws {
        //Arrange
        let validEpisodeCode: String = "S02E17"
        let expectedSeason: Int = 2
        let expectedEpisode: Int = 17
        
        //Act
        let (season, episode) = try validEpisodeCode.parseEpisode()
        
        //Assert
        XCTAssertEqual(season, expectedSeason)
        XCTAssertEqual(episode, expectedEpisode)
    }
    
    func test_StringExtensionParseEpisode_InvalidEpisodeCode_ShouldThrowParsingError() throws {
        //Arrange
        let invalidEpisodeCode: String = "D02S17"
        let expectedError: ParsingError = ParsingError.invalidFormat(invalidEpisodeCode)
        
        //Act
        
        //Assert
        XCTAssertThrowsError(try invalidEpisodeCode.parseEpisode()) { error in
            XCTAssertEqual(error as? ParsingError, expectedError)
        }
    }
    
    func test_StringExtensionParseToInt_ValidStringIntiger_ShouldParse() throws {
        //Arrange
        let validStringInt: String = "100"
        let expectedResult: Int = 100
        
        //Act
        let result = try validStringInt.asInt()
        
        //Assert
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_StringExtensionParseToInt_InvalidStringIntiger_ShouldThrowParsingError() throws {
        //Arrange
        let invalidStringInt: String = "xX1337Xx"
        let expectedError: ParsingError = .couldNotParse(invalidStringInt, toType: String(describing: Int.self))
        
        //Act
        
        //Assert
        XCTAssertThrowsError(try invalidStringInt.asInt()) { error in
            XCTAssertEqual(error as? ParsingError, expectedError)
        }
    }
}
