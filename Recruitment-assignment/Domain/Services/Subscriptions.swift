//
//  Subscriptions.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import Foundation
import Combine

final class Subscriptions {
    var cancelbag = Set<AnyCancellable>()
}

extension AnyCancellable {
    func store(in subscriptions: Subscriptions) {
        subscriptions.cancelbag.insert(self)
    }
}

