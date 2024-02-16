//
//  LocationListView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI
import SwiftUINavigation

struct LocationListView: View {
    @ObservedObject var vm: LocationListModel
    
    var body: some View {
        AsyncView(state: $vm.locations) { locations in
            ScrollView {
                ForEach(locations) { location in
                    GenericRowView(location.name, category: "Location", image: Image(systemName: "globe.central.south.asia.fill"), clickable: true)
                        .onTapGesture { vm.initateDestination(to: .details(location)) }
                }
            }
            .scrollIndicators(.never)
        }
        .navigationDestination(unwrapping: $vm.destination.details) { $location in LocationDetailsView(location: location.id).title("Locations") }
        
    }
    
    init(loadable locations: Loadable<[Location]> = .none) {
        self._vm = ObservedObject(initialValue: LocationListModel(loadable: locations))
    }
}
