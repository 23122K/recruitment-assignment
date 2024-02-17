//
//  CustomList.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import SwiftUI

struct CustomList<T: Identifiable & Hashable, Content: View>: View {
    @State private var offset = CGFloat.zero
    
    var elements: [T]
    var content: (T) -> Content
    var onAppearOfLastElement: (() -> Void)?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(elements) { element in
                    content(element)
                        .background(
                            GeometryReader { reader in
                                Color.clear.preference(
                                    key: ViewOffsetKey.self,
                                    value: reader.frame(in: .named("scroll")).origin.y.rounded() / (CGFloat(elements.count) * reader.size.height)
                                )
                            }
                        )
                }
            }
        }
        .coordinateSpace(name: "scroll")
        .scrollIndicators(.never)
        .onPreferenceChange(ViewOffsetKey.self) { offset in if offset <= 0 { onAppearOfLastElement?() }}
    }
    
    init(_ elements: [T], onAppearOfLastElement: (() -> Void)? = nil, @ViewBuilder _ content: @escaping (T) -> Content) {
        self.elements = elements
        self.content = content
        self.onAppearOfLastElement = onAppearOfLastElement
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
