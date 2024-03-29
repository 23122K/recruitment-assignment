//
//  CharacterInfoRowView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI

struct CharacterInfoRowView: View {
    let image: Image?
    let category: String
    let text: String
    let clickable: Bool
    
    
    var body: some View {
        HStack(alignment: .center) {
           image?
                .resizable()
                .frame(width: 25, height: 25)
                .scaledToFit()
                .foregroundStyle(Color.font)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: text)
                    .foregroundStyle(Color.font)
                    .fontWeight(.bold)
                Text(verbatim: category)
                    .font(.caption)
                    .foregroundStyle(Color.font)
            }
            .padding(.leading)
                
            Spacer()
            
            if clickable {
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color.font)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.secondary)
        }
    }
    
    init(_ text: String, category: String, image: Image? = .none, clickable: Bool = false) {
        self.text = text
        self.category = category
        self.image = image
        self.clickable = clickable
    }
}
