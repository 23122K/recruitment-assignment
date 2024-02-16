//
//  FiltersView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI

struct FiltersView: View {
    var filter: Binding<SearchModel.Filter>
    var onSelect: (SearchModel.Filter) -> Void
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                switch filter.wrappedValue {
                case let .character(selectedQuery):
                    ForEach(API.Endpoints.CharacterEndpoint.Query.allCases, id: \.id) { query in
                        TagView(query.description, selected: selectedQuery)
                            .onTapGesture { onSelect(.character(query)) }
                    }
                case let .location(selectedQuery):
                    ForEach(API.Endpoints.LocationEndpoint.Query.allCases, id: \.id) { query in
                        TagView(query.description, selected: selectedQuery)
                            .onTapGesture { onSelect(.location(query)) }
                    }
                case let .episode(selectedQuery):
                    ForEach(API.Endpoints.EpisodeEndpoint.Query.allCases, id: \.id) { query in
                        TagView(query.description, selected: selectedQuery)
                            .onTapGesture { onSelect(.episode(query)) }
                    }
                }
            }
        }
        .scrollIndicators(.never)
    }
    
    init(selected filter: Binding<SearchModel.Filter>, _ onSelect: @escaping (SearchModel.Filter) -> Void) {
        self.filter = filter
        self.onSelect = onSelect
    }
}
