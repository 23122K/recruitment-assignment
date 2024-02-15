//
//  Data+Extension.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

extension Data {
    func decode<T: Decodable>(to type: T.Type = T.self) async throws -> T {
        return try JSONDecoder().decode(type, from: self)
    }
}
