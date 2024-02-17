//
//  Container+Extension.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Foundation
import Factory

extension Container {
    func onSetUp() {
        characterRemoteRepository.register { MockCharacterRemoteRepository(session: .mock) }
        locationRemoteRepository.register { MockLocationRemoteRepository(session: .mock) }
        episodeRemoteRepository.register { MockEpisodeRemoteRepository(session: .mock) }
        favoriteCharacterStore.register { FavoriteCharacterStore(deafults: .mock(for: FavoriteCharacterStore.Keys.favoriteCharactersStoreKey))
        }
    }
    
    func onTearDown() {
        characterRemoteRepository.reset(.all)
        locationRemoteRepository.reset(.all)
        episodeRemoteRepository.reset(.all)
        favoriteCharacterStore.reset(.all)
    }
}
