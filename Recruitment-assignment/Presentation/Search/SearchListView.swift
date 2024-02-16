//
//  SearchListView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI

struct SearchListView: View {
    @ObservedObject private var vm: SearchModel
    
    var body: some View {
        switch vm.filter {
        case .character: CharactersListView(loadable: vm.characters)
        case .location: LocationListView(loadable: vm.locations)
        case .episode: EpisodeListView(loadable: vm.episodes)
        }
    }
    
    init(_ vm: SearchModel) {
        self._vm = ObservedObject(wrappedValue: vm)
    }
}
