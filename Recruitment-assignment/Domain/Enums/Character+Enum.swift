//
//  CharacterStatus.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

extension Character {
    enum Status: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
    
    enum Gender: String, Decodable {
        case feamle = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown = "unknown"
    }
}

extension Character.Status: CustomStringConvertible {
    var description: String {
        switch self {
        case .alive: String(localized: "Alive")
        case .dead: String(localized: "Dead")
        case .unknown: String(localized: "Unknown")
        }
    }
}

extension Character.Gender: CustomStringConvertible {
    var description: String {
        switch self {
        case .feamle: String(localized: "Female")
        case .male: String(localized: "Male")
        case .genderless: String(localized: "Genderless")
        case .unknown: String(localized: "Unknown")
        }
    }
}

