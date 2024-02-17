//
//  Episode+Extension.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

extension Episode {
    internal enum CodingKeys: String, CodingKey {
        case id
        case name
        case details = "episode"
        case aired = "air_date"
        case characters
    }
}

extension Episode {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.aired = try container.decode(String.self, forKey: .aired)
        
        self.characters = try container.decode([URL].self, forKey: .characters).compactMap { url in
            try url.lastPathComponent.asInt()
        }
        
        let (number, season) = try container.decode(String.self, forKey: .details).parseEpisode()
        self.number = number
        self.season = season
    }
}
