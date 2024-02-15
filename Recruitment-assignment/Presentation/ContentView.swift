//
//  ContentView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 15/02/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = ViewModel()
    
    var body: some View {
        VStack {
            Button("Fetch") { vm.initiateGetAllEpisodes() }
            List(vm.locations) { location in
                HStack {
//                    AsyncImage(url: character.image)
//                        .frame(width: 20, height: 20)
                    Text(location.name)
                    Text(location.characters.description)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var locations: [Location] = []
        
        let repository = LocationRemoteRepository()
        
        func initiateGetAllEpisodes() {
            Task(priority: .userInitiated) {
                do {
                    self.locations = try await repository.getAll().results
                } catch { print(error) }
            }
        }
        
    }
}
