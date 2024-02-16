//
//  LocationDetailsModel.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import Factory
import Foundation
import SwiftUINavigation

@MainActor
class LocationDetailsModel: ObservableObject {
    @Published var location: Loadable<Location> = .none
    @Published var destination: Destination? = .none
    
    @Injected(\.locationRemoteRepository) private var locationRemoteRepository
    
    @CasePathable
    enum Destination {
        case characters(_ characters: [Character.ID])
    }
    
    func getLocation(_ location: Character.Location) {
        Task(priority: .userInitiated) {
            do {
                self.location = .loading
                let result = try await locationRemoteRepository.getLocation(with: location.id.unsafelyUnwrapped)
                self.location = .loaded(result)
            } catch { self.location = .failed(error) }
        }
    }
    
    func initiadeDestination(to destination: Destination) {
        self.destination = destination
    }
    
    init(location: Character.Location) {
        getLocation(location)
    }
}
