//
//  TagView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI

struct TagView<T: Identifiable & CustomStringConvertible>: View {
    let text: String
    let selected: T
    
    var body: some View {
        Text(verbatim: text)
            .foregroundStyle(Color.font)
            .padding()
            .frame(height: 40)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(selected.description == text ? Color.accentColor : Color.secondary)
            }
    }
    
    init(_ text: String, selected: T) {
        self.text = text
        self.selected = selected
    }
}
