//
//  AsyncView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import SwiftUI

struct AsyncView<T: Equatable, Content: View, Placeholder: View>: View {
    @Binding var state: Loadable<T>
    var placeholder: Placeholder
    var content: (T) -> Content
    
    var body: some View {
        switch state {
        case .none: Color.clear
        case .loading: placeholder
        case let .failed(error): rickrorr(description: error.localizedDescription)
        case let .loaded(data): content(data)
        }
    }
    
    @ViewBuilder
    private func rickrorr(description: String) -> some View {
        let textGradient = Gradient(colors: [Color.clear, Color.primary.opacity(0.4)])
        let imageGradient = Gradient(colors: [Color.clear, Color.primary])
        
        VStack {
            Spacer()
            
            VStack {
                Text("Oopsie...")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.font)
                    .overlay(LinearGradient(gradient: textGradient, startPoint: .bottomLeading, endPoint: .topTrailing))
                
                Text(description)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.font)
                    .overlay(LinearGradient(gradient: textGradient, startPoint: .bottomLeading, endPoint: .topTrailing))
            }
            
            Spacer()
            
            Image("rickrorr")
                .resizable()
                .scaledToFit()
                .overlay(LinearGradient(gradient: imageGradient, startPoint: .top, endPoint: .bottom))
                .padding(.top)
        }
    }
    
    init(state: Binding<Loadable<T>>, placeholder: Placeholder, @ViewBuilder _ content: @escaping (T) -> Content) {
        self._state = state
        self.placeholder = placeholder
        self.content = content
    }
}
