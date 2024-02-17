//
//  WelcomeModel.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import Foundation
import SwiftUINavigation

class WelcomeModel: ObservableObject {
    @Published var destination: Destination?
    
    func initateDestination(to destination: Destination) {
        self.destination = destination
    }
    
    @CasePathable
    enum Destination: Equatable {
        case characters
    }
    
    init(destination: Destination? = .none) {
        self.destination = destination
    }
}
