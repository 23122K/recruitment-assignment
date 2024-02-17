//
//  CharactersListFeature.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import Factory
import Foundation
import SwiftUINavigation

@MainActor
class CharactersListModel: ObservableObject {
    @Published var characters: Loadable<[Character]>
    @Published var favorite: [Character.ID]
    @Published var destination: Destination?
    
    @Injected(\.characterRemoteRepository) private var characterRemoteRepository
    @Injected(\.favoriteCharacterStore) private var favoriteCharacterStore
    @Injected(\.subscrptions) private var subscrptions
    
    @CasePathable
    enum Destination: Equatable {
        case details(_ character: Character)
    }
    
    func initiateDestination(to destination: Destination) {
        self.destination = destination
    }
    
    func initiateDiscardAllFetchedCharacters() {
        self.characters = .none
    }
    
    func initateToggleFavorite(for character: Character) {
        switch favorite.contains(character.id) {
        case true: favoriteCharacterStore.delete(character)
        case false: favoriteCharacterStore.add(character)
        }
    }
    
    func initateGetAllFavoritedCharacters() {
        self.favorite = favoriteCharacterStore.get()
    }
    
    func initateGetAllCharacters() async {
        self.characters = .loading
        do {
            let results = try await characterRemoteRepository.getAll().results
            self.characters = .loaded(results)
        } catch { self.characters = .failed(error) }
    }
    
    func initiateGetCharacters(with ids: [Character.ID]) async {
        do {
            let results = try await characterRemoteRepository.getCharacters(with: ids)
            self.characters = .loaded(results)
        } catch { self.characters = .failed(error) }
    }
    
    init(
        character ids: [Character.ID]? = .none,
        loadable characters: Loadable<[Character]>? = nil,
        favorite: [Character.ID] = [],
        destination: Destination? = .none
    ) {
        self.favorite = favorite
        self.destination = destination
        
        switch ids {
        case let .some(ids):
            self.characters = .none
            Task { await self.initiateGetCharacters(with: ids) }
        case .none:
            switch characters {
            case nil:
                self.characters = .none
                Task { await self.initateGetAllCharacters() }
            case let .some(characters):
                self.characters = characters
            }
        }
        
        self.favoriteCharacterStore.$didChange
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in Task { self?.initateGetAllFavoritedCharacters() } }
            .store(in: &subscrptions.cancelbag)
    }
}
