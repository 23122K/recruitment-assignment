//
//  MockStoreTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import XCTest

final class MockStoreTests: XCTestCase {
    var sut: MockStore!
    
    override func setUp() { self.sut = MockStore(deafults: .mock(for: MockStore.Keys.mockStoreKey)) }
    override func tearDown() { self.sut = nil }
    
    func test_MockStoreTests_BootstrapMethod_shoudCreateStoreForKey() throws {
        //Arrange
        let expectedResult: Bool = true
        
        //Act
        let result = sut.isKeyPresentInStore(key: MockStore.Keys.mockStoreKey)
        
        //Arrange
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_MockStoreTests_getMethod_validParameters_shoudReturn() throws {
        //Arrange
        let expectedResultCount: Int = 0
        
        //Act
        let result = sut.get()
        
        //Arrange
        XCTAssertEqual(result.count, expectedResultCount)
    }
    
    func test_MockStoreTests_addMethod_validParametes_shouldPersist() throws {
        //Arrange
        let number: Int = 1
        
        let expectedCount: Int = 1
        
        //Act
        sut.add(number)
        let result = sut.get()
        
        //Assert
        XCTAssertEqual(result.count, expectedCount)
        XCTAssertTrue(result.contains(number))
    }
    
    func test_MockStoreTests_addMethod_duplicateParameters_shouldPersistOnlyOny() throws {
        //Arrange
        let initialNumbers: [Int] = [1,2,3]
        let number: Int = 1
        
        let expectedCount: Int = 3
        
        //Act
        initialNumbers.forEach { number in sut.add(number) }
        sut.add(number)
        let result = sut.get()
        
        //Assert
        XCTAssertEqual(result.count, expectedCount)
        XCTAssertTrue(result.contains(number))
    }
    
    func test_MockStoreTests_deleteMethod_validParametes_shouldDelete() throws {
        //Arrange
        let initialNumbers: [Int] = [1,2,3]
        
        let number: Int = 2
        let expectedCount: Int = 2
        
        //Act
        initialNumbers.forEach { number in sut.add(number) }
        sut.delete(number)
        let result = sut.get()
        
        //Assert
        XCTAssertEqual(result.count, expectedCount)
        XCTAssertFalse(result.contains(number))
    }
}
