//
//  Loadable+Extension.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import Foundation

extension Loadable {
    var value: Value? {
        switch self {
        case let .loaded(value): return .some(value)
        default: return .none
        }
    }
}
