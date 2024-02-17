//
//  Location+Extension.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

extension Character {
    internal enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case gender
        case origin
        case location
        case episodes = "episode"
        case image
    }
}

extension Character {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(Character.Status.self, forKey: .status)
        self.gender = try container.decode(Character.Gender.self, forKey: .gender)
        self.origin = try container.decode(Character.Location.self, forKey: .origin)
        self.location = try container.decode(Character.Location.self, forKey: .location)
        self.image = try container.decode(URL.self, forKey: .image)
        
        self.episodes = try container.decode([URL].self, forKey: .episodes).compactMap { url in
            try url.lastPathComponent.asInt()
        }
    }
}

extension Character {
    struct Location: Hashable, Decodable {
        let id: Int?
        let name: String
    }
}

extension Character.Location {
    internal enum CodingKeys: String, CodingKey {
        case id = "url"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //Apparently if location does not have a "url" aka is "unknow", empty String is passed instead of null value
        self.id = try? container.decode(URL.self, forKey: CodingKeys.id).lastPathComponent.asInt()
        self.name = try container.decode(String.self, forKey: CodingKeys.name)
    }
}
