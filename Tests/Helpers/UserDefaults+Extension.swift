//
//  UserDefaults+Extension.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import Foundation

extension UserDefaults {
    static func mock(for key: String) -> UserDefaults {
        let defaults = UserDefaults.standard
        defaults.removePersistentDomain(forName: key)
        defaults.removeObject(forKey: key)
        return defaults
    }
}
