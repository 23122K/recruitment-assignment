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
        AsyncView(state: $vm.locations, placeholder: LocationListView.Placeholder()) { locations in
            ScrollView {
                ForEach(locations) { location in
                    GenericRowView(location.name, category: "Location", image: Image(systemName: "globe.central.south.asia.fill"), clickable: true)
                        .onTapGesture { vm.initateDestination(to: .details(location)) }
                }
            }
            .scrollIndicators(.never)
        }
        .animation(.bouncy, value: vm.locations.isLoaded)
        .navigationDestination(unwrapping: $vm.destination.details) { $location in LocationDetailsView(location: location.id).title("Locations") }
        
    }
    
    init(loadable locations: Loadable<[Location]> = .none) {
        self._vm = ObservedObject(initialValue: LocationListModel(loadable: locations))
    }
}

extension LocationListView {
    struct Placeholder: View {
        var body: some View {
            ScrollView {
                ForEach(0...Int.random(in: 3...8), id: \.self) { _ in
                    GenericRowView.Redacted()
                }
            }
            .scrollIndicators(.never)
        }
    }
}
