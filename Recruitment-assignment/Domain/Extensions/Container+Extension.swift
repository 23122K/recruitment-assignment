//
//  Container+Extension.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import Factory

extension Container {
    var characterRemoteRepository: Factory<CharacterRemoteRepository> {
        self { CharacterRemoteRepository() }
            .singleton
    }
    
    var locationRemoteRepository: Factory<LocationRemoteRepository> {
        self { LocationRemoteRepository() }
            .singleton
    }
    
    var episodeRemoteRepository: Factory<EpisodeRemoteRepository> {
        self { EpisodeRemoteRepository() }
            .singleton
    }
}
