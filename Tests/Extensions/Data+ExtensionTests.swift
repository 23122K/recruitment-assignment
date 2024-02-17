//
//  Data+ExtensionTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import XCTest

final class Data_ExtensionTests: XCTestCase {
    func test_DataExtensionDecodeDecodable_ValidDecodableObject_shouldDecode() throws {
        //Arrange
        let data: Data = """
            {
                "name": "Patryk",
                "surname": "Maciag",
                "age": 88
            }
            """.data(using: .utf8).unsafelyUnwrapped
        let expectedName: String = "Patryk"
        let expectedSurname: String = "Maciag"
        let expectedAge: Int = 88
    
        //Act
        let result = try data.decode(to: Person.self)
    
        //Assert
        XCTAssertEqual(result.name, expectedName)
        XCTAssertEqual(result.surname, expectedSurname)
        XCTAssertEqual(result.age, expectedAge)
    }

    func test_DataExtensionDecodeDecodable_InvalidDecodableObject_shouldThrowError() throws {
        //Arrange
        let data: Data = """
            {
                "name": "Patryk",
                "lastName": "Maciag",
                "age": null
            }
            """.data(using: .utf8).unsafelyUnwrapped
    
        //Act
        let result = try? data.decode(to: Person.self)
    
        //Assert
        XCTAssertNil(result)
    }

}

extension Data_ExtensionTests {
    struct Person: Decodable {
        let name: String
        let surname: String
        let age: Int
    }
}
