//
//  CustomNavigationViewModifier.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI

struct CustomNavigationViewModifier: ViewModifier {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var title: String
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                HStack {
                    Image(systemName: "chevron.left")
                    Text(verbatim: title)
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .foregroundStyle(Color.font)
                .animation(.spring, value: dragOffset)
            })
            .frame(maxWidth: .infinity, maxHeight : .infinity)
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                if(value.startLocation.x < 20 && value.translation.width > 100) {
                    self.mode.wrappedValue.dismiss()
                }
            }))
    }
}

extension View {
    func title(_ title: String) -> some View {
        self.modifier(CustomNavigationViewModifier(title: title))
    }
}
