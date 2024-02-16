//
//  EpisodeRowView.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 16/02/2024.
//

import SwiftUI

struct EpisodeRowView: View {
    let image: Image?
    let name: String
    let number: Int
    let season: Int
    
    var body: some View {
        HStack(alignment: .center) {
           image?
                .resizable()
                .frame(width: 25, height: 25)
                .scaledToFit()
                .foregroundStyle(Color.font)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(verbatim: name)
                    .foregroundStyle(Color.font)
                    .fontWeight(.bold)
                HStack {
                    Text(verbatim: "Episode \(number)")
                        .font(.caption)
                        .foregroundStyle(Color.font)
                    
                    Text(verbatim: "Season \(season)")
                        .font(.caption)
                        .foregroundStyle(Color.font)
                }
            }
            .padding(.leading)
                
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.secondary)
        }
    }
    
    init(_ name: String, number: Int, season: Int, image: Image? = .none) {
        self.name = name
        self.number = number
        self.season = season
        self.image = image
    }
}
