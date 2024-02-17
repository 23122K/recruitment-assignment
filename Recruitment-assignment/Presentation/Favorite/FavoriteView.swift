//
//  FavoriteView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var vm = FavoriteModel()
    
    var body: some View {
        NavigationStack {
            CharactersListView(character: vm.characters)
        }
    }
}

#Preview {
    FavoriteView()
}
