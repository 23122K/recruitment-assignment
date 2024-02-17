//
//  CharactersDetailsSelectedTabView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import SwiftUI

struct CharactersDetailsSelectedTabView: View {
    @Binding var selection: CharactersDetailsView.Tab
    let character: Character
    
    var body: some View {
        HStack(spacing: 0) {
            GenericRowView("Details", category: "Character details", image: Image(systemName: "info.circle"))
                .opacity(selection == .details ? 1 : 0.5)
                .onTapGesture { selection = .details }
            Spacer()
            GenericRowView("Episodes", category: "In \(character.episodes.count) episodes", image: Image(systemName: "movieclapper"))
                .opacity(selection == .episodes ? 1 : 0.5)
                .onTapGesture { selection = .episodes }
        }
        .padding(.horizontal, 5)
        .padding(.bottom, 3)
        .animation(.spring, value: selection)
    }
}
