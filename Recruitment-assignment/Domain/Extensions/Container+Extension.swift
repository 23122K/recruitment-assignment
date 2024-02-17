//
//  Container+Extension.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import Factory

extension Container {
    var subscrptions: Factory<Subscriptions> {
        self { Subscriptions() }
            .singleton
    }
    
    //MARK: - UserDefaults Stores
    var favoriteCharacterStore: Factory<FavoriteCharacterStore> {
        self { FavoriteCharacterStore() }
            .singleton
    }
 
    //MARK: - Repositories
    var characterRemoteRepository: Factory<CharacterRemoteRepository> {
        self { RealCharacterRemoteRepository() }
            .singleton
    }
    
    var locationRemoteRepository: Factory<LocationRemoteRepository> {
        self { RealLocationRemoteRepository() }
            .singleton
    }
    
    var episodeRemoteRepository: Factory<EpisodeRemoteRepository> {
        self { RealEpisodeRemoteRepository() }
            .singleton
    }
}
