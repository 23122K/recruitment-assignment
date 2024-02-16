//
//  WelcomeView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI
import SwiftUINavigation

struct WelcomeView: View {
    @StateObject var vm = WelcomeModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("portal")
                    .resizable()
                    .scaledToFit()
                    .onTapGesture { vm.initateDestination(to: .characters) }
                Text("Simply, tap the portal to see the list of all characters")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.font)
                    .padding()
                    .overlay(LinearGradient(gradient: gradient, startPoint: .bottomLeading, endPoint: .topTrailing))
            }
            .navigationDestination(unwrapping: $vm.destination.characters) { $_ in
                CharactersListView()
                    .title("Portal")
            }
        }
    }
}

extension WelcomeView {
    private var gradient: Gradient { Gradient(colors: [Color.clear, Color.primary.opacity(0.5)]) }
}

class WelcomeModel: ObservableObject {
    @Published var destination: Destination?
    
    func initateDestination(to destination: Destination) {
        print(destination)
        self.destination = destination
    }
    
    @CasePathable
    enum Destination {
        case characters
    }
}
