//
//  HorizontalCarousel.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import SwiftUI

struct HorizontalCarousel<T: Identifiable & CustomStringConvertible, Content: View>: View {
    var elements: [T]
    var content: (T) -> Content
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(elements) { element in
                    content(element)
                }
                
            }
        }
        .scrollIndicators(.never)
    }
    
    init(elements: [T], @ViewBuilder _ content: @escaping (T) -> Content) {
        self.elements = elements
        self.content = content
    }
}
