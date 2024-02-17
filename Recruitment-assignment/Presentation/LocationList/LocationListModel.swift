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
    @Published var destination: Destination?
    
    @Injected(\.locationRemoteRepository) private var locationRemoteRepository
    
    @CasePathable
    enum Destination: Equatable {
        case details(_ location: Location)
    }
    
    func initateDestination(to destination: Destination) {
        self.destination = destination
    }
    
    init(loadable locations: Loadable<[Location]> = .none, destination: Destination? = .none) {
        self.locations = locations
        self.destination = destination
    }
}


