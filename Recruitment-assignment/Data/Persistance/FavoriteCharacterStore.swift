//
//  FavoriteStore.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import Foundation

class FavoriteCharacterStore: ObservableObject, UserDefaultsStore {
    internal typealias T = Character
    internal typealias U = [Character.ID]
    
    internal var defaults: UserDefaults
    @Published private(set) var didChange: Bool
    
    func add(_ character: Character) {
        defer { didChange.toggle() }
        
        var characters: Set<Character.ID> = Set(self.get())
        characters.insert(character.id)
        defaults.setValue(Array(characters), forKey: Keys.favoriteCharactersStoreKey)
    }
    
    func delete(_ character: Character) {
        defer { didChange.toggle() }
        
        var characters: Set<Character.ID> = Set(self.get())
        characters.remove(character.id)
        defaults.setValue(Array(characters), forKey: Keys.favoriteCharactersStoreKey)
    }
    
    func get() -> [Character.ID] {
        guard let ids = defaults.array(forKey: Keys.favoriteCharactersStoreKey) as? [Int] else { return [] }
        return ids
    }
    
    private func bootstrap(defaults: UserDefaults) {
        defer { didChange.toggle() }
        
        let value: [Character.ID] = []
        defaults.set(value, forKey: Keys.favoriteCharactersStoreKey)
    }
    
    init(deafults: UserDefaults = .standard, didChange: Bool = false) {
        self.defaults = deafults
        self.didChange = didChange
    
        if defaults.bool(forKey: Keys.favoriteCharactersStoreKey) { bootstrap(defaults: defaults) }
    }
}

extension FavoriteCharacterStore {
    struct Keys {
        static let favoriteCharactersStoreKey: String = "favoriteCharacters"
    }
}

