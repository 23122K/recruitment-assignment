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
    @Published var characters: Loadable<[Character]> = .none
    @Published var destination: Destination? = .none
    
    @Injected(\.characterRemoteRepository) private var characterRemoteRepository
    
    @CasePathable
    enum Destination {
        case details(_ character: Character)
    }
    
    func initiateDestination(to destination: Destination) {
        self.destination = destination
    }
    
    func getAllCharactersButtonTapped() {
        Task(priority: .userInitiated) {
            self.characters = .loading
            do {
                let results = try await characterRemoteRepository.getAll().results
                self.characters = .loaded(results)
            } catch { self.characters = .failed(error) }
        }
    }
    
    func getAllCharactersWithGivenIds(characters ids: [Character.ID]) {
        Task(priority: .userInitiated) {
            self.characters = .loading
            do {
                let results = try await characterRemoteRepository.getCharacters(with: ids)
                self.characters = .loaded(results)
            } catch { self.characters = .failed(error) }
        }
    }
    
    init(character ids: [Character.ID]? = .none) {
        switch ids {
        case let .some(ids): getAllCharactersWithGivenIds(characters: ids)
        case .none: break
        }
    }
}
