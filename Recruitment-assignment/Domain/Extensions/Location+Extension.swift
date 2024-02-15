//
//  Location+Extension.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

extension Location {
    internal enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case dimension
        case characters = "residents"
    }
}

extension Location {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
        self.dimension = try container.decode(String.self, forKey: .dimension)
        
        self.characters = try container.decode([URL].self, forKey: .characters).compactMap { url in
            try url.lastPathComponent.asInt()
        }
    }
}
