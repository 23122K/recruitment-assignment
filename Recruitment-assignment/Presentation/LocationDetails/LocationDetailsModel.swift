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
    @Published var location: Loadable<Location>
    @Published var destination: Destination?
    
    @Injected(\.locationRemoteRepository) private var locationRemoteRepository
    
    @CasePathable
    enum Destination: Equatable {
        case characters(_ characters: [Character.ID])
    }
    
    func initateGetLocation(location id: Location.ID) async {
        do {
            self.location = .loading
            let result = try await locationRemoteRepository.getLocation(with: id)
            self.location = .loaded(result)
        } catch { self.location = .failed(error) }
    }
    
    func initiadeDestination(to destination: Destination) {
        self.destination = destination
    }
    
    init(location id: Location.ID, loadable location: Loadable<Location> = .none, destination: Destination? = .none) {
        self.location = location
        self.destination = destination
        
        Task { await self.initateGetLocation(location: id) }
    }
}
