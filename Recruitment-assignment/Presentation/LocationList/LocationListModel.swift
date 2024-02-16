//
//  LocationListModel.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import Factory
import Foundation
import SwiftUINavigation

@MainActor
class LocationListModel: ObservableObject {
    @Published var locations: Loadable<[Location]>
    @Published var destination: Destination? = .none
    
    @Injected(\.locationRemoteRepository) private var locationRemoteRepository
    
    @CasePathable
    enum Destination {
        case details(_ location: Location)
    }
    
    func initateGetAllLocations() {
        Task(priority: .userInitiated) {
            do {
                self.locations = .loading
                let result = try await locationRemoteRepository.getAll().results
                self.locations = .loaded(result)
            } catch { self.locations = .failed(error) }
        }
    }
    
    func initateDestination(to destination: Destination) {
        self.destination = destination
    }
    
    init(loadable locations: Loadable<[Location]> = .none, destination: Destination? = .none) {
        self.locations = locations
        self.destination = destination
    }
}

