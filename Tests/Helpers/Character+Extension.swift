//
//  Character+Extension.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Foundation

extension Character {
    static func mock(id: Int = 1) -> Character {
        Character(
            id: id,
            name: "Rick Smith",
            status: .alive,
            gender: .male,
            origin: Character.Location(id: 1, name: "Earth"),
            location: Character.Location(id: 1, name: "Earth"),
            episodes: [1,2,3],
            image: URL(string: "mock.com").unsafelyUnwrapped
        )
    }
    
    static func mocks(ids: [Int] = [1,2,3]) -> [Character] {
        return ids.map { id in Character.mock(id: id) }
    }
    
}
