//
//  Episode+Extension.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Foundation

extension Episode {
    static func mock(id: Int = 1) -> Episode {
        Episode(
            id: id,
            name: "Pilor",
            aired: "02.17.2024",
            number: 1,
            season: 1,
            characters: [1,2,3,4]
        )
    }
    
    static func mocs(ids: [Int] = [1,2,3]) -> [Episode] {
        return ids.map { id in Episode.mock(id: id) }
    }
}
