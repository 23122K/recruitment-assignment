//
//  Episode.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

struct Episode: Identifiable, Hashable, Decodable {
    let id: Int
    let name: String
    let aired: String
    let number: Int
    let season: Int
    let characters: [Episode.ID]
}
