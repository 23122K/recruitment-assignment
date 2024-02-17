//
//  FavoriteModel.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import Factory
import Foundation

class FavoriteModel: ObservableObject {
    @Published var characters: [Character.ID]
    
    @Injected(\.favoriteCharacterStore) private var favoriteCharacterStore
    @Injected(\.subscrptions) private var subscrptions
    
    func initateDelete(character: Character) {
        favoriteCharacterStore.delete(character)
    }
    
    func initateGetAllFavoritedCharacters() {
        self.characters = favoriteCharacterStore.get()
    }
    
    init(characters: [Character.ID] = []) {
        self.characters = characters
        self.initateGetAllFavoritedCharacters()
        
        self.favoriteCharacterStore.$didChange
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.initateGetAllFavoritedCharacters() }
            .store(in: &subscrptions.cancelbag)
    }
}
