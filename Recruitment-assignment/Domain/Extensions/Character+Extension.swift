//
//  Location+Extension.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

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
