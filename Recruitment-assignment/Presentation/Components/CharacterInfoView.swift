//
//  CharacterInfoView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI
import SwiftUINavigation

struct CharacterInfoView: View {
    @ObservedObject var vm: CharacterInfoModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                CharacterInfoRowView(vm.character.status.description, category: "Status", image: Image(systemName: "cross"))
                CharacterInfoRowView(vm.character.origin.name, category: "Origin", image: Image(systemName: "globe.asia.australia"), clickable: true)
                    .onTapGesture { vm.initateDestination(to: .details(location: vm.character.origin)) }
                CharacterInfoRowView(vm.character.location.name, category: "Current location", image: Image(systemName: "globe.europe.africa.fill"), clickable: true)
                    .onTapGesture { vm.initateDestination(to: .details(location: vm.character.location)) }
                CharacterInfoRowView(vm.character.gender.description, category: "Gender", image: Image(systemName: "person.fill"))
            }
            .scrollIndicators(.never)
            .navigationDestination(unwrapping: $vm.destination.details) { $location in
                LocationDetailsView(location)
                    .title(vm.character.name)
            }
        }
    }
    
    init(_ character: Character) { self._vm = ObservedObject(initialValue: CharacterInfoModel(character: character)) }
}

class CharacterInfoModel: ObservableObject {
    @Published var character: Character
    @Published var destination: Destination?
    
    @CasePathable
    enum Destination {
        case details(location: Character.Location)
    }
    
    func initateDestination(to destination: Destination) {
        self.destination = destination
    }
    
    init(character: Character, destination: Destination? = nil) {
        self.character = character
        self.destination = destination
    }
}
