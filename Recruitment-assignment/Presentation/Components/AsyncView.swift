//
//  AsyncView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import SwiftUI

struct AsyncView<T: Any, Content: View>: View {
    @Binding var state: Loadable<T>
    var content: (T) -> Content
    
    var body: some View {
        switch state {
        case .none: Color.clear
        case .loading: Color.red
        case let .failed(error): Text(error.localizedDescription)
        case let .loaded(data): content(data)
        }
    }
    
    init(state: Binding<Loadable<T>>, @ViewBuilder _ content: @escaping (T) -> Content) {
        self._state = state
        self.content = content
    }
}
