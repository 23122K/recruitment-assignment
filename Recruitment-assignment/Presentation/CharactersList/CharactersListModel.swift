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
    @Published var destination: Destination?
    
    @Injected(\.characterRemoteRepository) private var characterRemoteRepository
    
    @CasePathable
    enum Destination {
        case details(_ character: Character)
    }
    
    func initiateDestination(to destination: Destination) {
        self.destination = destination
    }
    
    func initiateDiscardAllFetchedCharacters() {
        self.characters = .none
    }
    
    func initateGetAllCharacters() {
        Task(priority: .userInitiated) {
            self.characters = .loading
            do {
                let results = try await characterRemoteRepository.getAll().results
                self.characters = .loaded(results)
            } catch { self.characters = .failed(error) }
        }
    }
    
    func initiateGetCharacters(with ids: [Character.ID]) {
        Task(priority: .userInitiated) {
            self.characters = .loading
            do {
                let results = try await characterRemoteRepository.getCharacters(with: ids)
                self.characters = .loaded(results)
            } catch { self.characters = .failed(error) }
        }
    }
    
    init(character ids: [Character.ID]? = .none, loadable characters: Optional<Loadable<[Character]>> = nil, destination: Destination? = .none) {
        self.destination = destination
        
        switch ids {
        case let .some(ids):
            self.characters = .none
            self.initiateGetCharacters(with: ids)
        case .none:
            switch characters {
            case nil:
                self.characters = .none
                self.initateGetAllCharacters()
            case let .some(characters):
                self.characters = characters
            }
        }
    }
}
