//
//  SearchBar.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI

struct SearchBar<T: Hashable>: View {
    @State private var focused: Bool = true
    
    @Binding var text: String
    var focus: FocusState<T>.Binding
    var field: T
    var onSubmit: () -> Void
    var onCancel: () -> Void
    
    var body: some View {
        HStack {
            HStack(spacing: 5){
                Image(systemName: "magnifyingglass")
                    .scaledToFit()
                    .frame(width: 30)
                    .padding(.leading, 5)
                    .foregroundColor(Color.font)
                
                TextField("Search...", text: $text)
                    .focused(focus, equals: field)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .foregroundColor(Color.font)
                    .onTapGesture { if !focused { focused.toggle() } }
                    .onSubmit { focused.toggle(); onSubmit() }
            }
            .frame(height: 40)
            .background(content: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.secondary)
            })
            
            if focused { Button("Cancel") { focused.toggle(); onCancel() }.foregroundStyle(Color.font) }
        }
        .animation(.bouncy, value: focused)
        .padding(.bottom, 2)
    }
    
    init(_ text: Binding<String>, focus: FocusState<T>.Binding, equals field: T, onSubmit: @escaping () -> Void, onCancel: @escaping () -> Void) {
        self._text = text
        self.focus = focus
        self.field = field
        self.onSubmit = onSubmit
        self.onCancel = onCancel
    }
}
