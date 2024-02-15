//
//  Character.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

struct Character: Identifiable, Hashable, Decodable {
    let id: Int
    let name: String
    let status: Character.Status
    let gender: Character.Gender
    let origin: Character.Location
    let location: Character.Location
    let image: URL
}
