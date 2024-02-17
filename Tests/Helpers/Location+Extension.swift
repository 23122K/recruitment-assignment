//
//  Location+Extension.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Foundation

extension Location {
    static func mock(id: Int = 1) -> Location {
        Location(
            id: 1,
            name: "Earth",
            type: "Planet",
            dimension: "Normal",
            characters: [1,2,3,4]
        )
    }
    
    static func mocs(ids: [Int] = [1,2,3]) -> [Location] {
        return ids.map { id in Location.mock(id: id) }
    }
    
}
