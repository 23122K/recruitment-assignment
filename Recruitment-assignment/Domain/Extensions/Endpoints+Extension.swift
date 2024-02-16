//
//  Endpoints+Extension.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import Foundation

extension API.Endpoints.CharacterEndpoint.Query: Identifiable, CaseIterable, CustomStringConvertible {
    var id: Self { self }
    static var allCases: [API.Endpoints.CharacterEndpoint.Query] = [.name, .gender, .species, .status, .type]
    
    var description: String {
        switch self {
        case .gender: String(localized: "Gender")
        case .name: String(localized: "Name")
        case .species: String(localized: "Species")
        case .status: String(localized: "Status")
        case .type: String(localized: "Type")
        }
    }
}

extension API.Endpoints.LocationEndpoint.Query: Identifiable, CaseIterable, CustomStringConvertible {
    var id: Self { self }
    static var allCases: [API.Endpoints.LocationEndpoint.Query] = [.name, .dimension, .type]
    
    var description: String {
        switch self {
        case .dimension: String(localized: "Dimension")
        case .name: String(localized: "Name")
        case .type: String(localized: "Type")
        }
    }
}

extension API.Endpoints.EpisodeEndpoint.Query: Identifiable, CaseIterable, CustomStringConvertible {
    var id: Self { self }
    static var allCases: [API.Endpoints.EpisodeEndpoint.Query] = [.name, .numberOrSeason]
    
    var description: String {
        switch self {
        case .name: String(localized: "Name")
        case .numberOrSeason: String(localized: "Episode no./Season")
        }
    }
}
