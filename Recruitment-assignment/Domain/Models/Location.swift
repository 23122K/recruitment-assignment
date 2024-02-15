//
//  Location.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

struct Location: Identifiable, Hashable, Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let characters: [Character.ID]
}
