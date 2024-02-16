//
//  EpisodeDetailsModel.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import Factory
import Foundation
import SwiftUINavigation

@MainActor
class EpisodeDetailsModel: ObservableObject {
    @Published var episode: Episode
    @Published var destination: Destination? = .none
    
    @Injected(\.characterRemoteRepository) private var characterRemoteRepository
    
    @CasePathable
    enum Destination {
        case characters(_ characters: [Character.ID])
    }
    
    func initiadeDestination(to destination: Destination) {
        self.destination = destination
    }
    
    init(episode: Episode) { self.episode = episode }
}
