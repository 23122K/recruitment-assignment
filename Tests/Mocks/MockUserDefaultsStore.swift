//
//  MockUserDefaultsStore.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Foundation

class MockStore: UserDefaultsStore {
    internal typealias T = Int
    internal typealias U = [Int]
    internal var defaults: UserDefaults
    
    func add(_ number: Int) {
        var numbers: Set<Int> = Set(self.get())
        numbers.insert(number)
        defaults.setValue(Array(numbers), forKey: Keys.mockStoreKey)
    }
    
    func delete(_ number: Int) {
        var numbers: Set<Int> = Set(self.get())
        numbers.remove(number)
        defaults.setValue(Array(numbers), forKey: Keys.mockStoreKey)
    }
    
    func get() -> [Int] {
        guard let numbers = defaults.array(forKey: Keys.mockStoreKey) as? [Int] else { return [] }
        return numbers
    }
    
    private func bootstrap(defaults: UserDefaults) {
        let value: [Int] = []
        defaults.set(value, forKey: Keys.mockStoreKey)
    }
    
    init(deafults: UserDefaults) {
        self.defaults = deafults

        if !isKeyPresentInStore(key: Keys.mockStoreKey) { bootstrap(defaults: defaults) }
    }
}

extension MockStore {
    struct Keys {
        static let mockStoreKey: String = "mockStoreKey"
    }
}
