//
//  SearchView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var vm = SearchModel()
    @FocusState private var focus: SearchModel.Field?
    
    private func initateSetFocusToSearchBar() async {
        try? await Task.sleep(for: .nanoseconds(10))
        self.focus = .search
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar($vm.phrase, focus: $focus, equals: .search, onSubmit: { focus = .none }, onCancel: {focus = .none})
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(vm.filters) { filter in
                            TagView(filter.description, selected: vm.filter)
                                .onTapGesture { vm.initateUpdateFilters(for: filter) }
                        }
                        
                    }
                }
                FiltersView(selected: $vm.filter) { filter in vm.initateUpdateFilters(for: filter) }
                Spacer()
                SearchListView(vm)
            }
            .task { await initateSetFocusToSearchBar() }
        }
    }
}

#Preview {
    SearchView()
}
