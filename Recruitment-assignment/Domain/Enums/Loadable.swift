//
//  Loadable.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Foundation

enum Loadable<Value> {
    case none
    case loading
    case failed(Error)
    case loaded(Value)
}

extension Loadable {
    var isLoaded: Bool {
        switch self {
        case .loaded: true
        default: false
        }
    }
}
