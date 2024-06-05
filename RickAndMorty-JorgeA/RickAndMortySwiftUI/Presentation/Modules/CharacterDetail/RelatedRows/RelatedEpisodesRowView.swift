//
//  RelatedEpisodesRowView.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import SwiftUI

struct RelatedEpisodesRow: View {
    @State var episodeText: String

    var body: some View {
        Text(episodeText)
            .font(.system(size: 14))
            .frame(minWidth: 80, maxWidth: .infinity, minHeight: 40)
            .font(.system(size: 18))
            .padding(4)
            .foregroundColor(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.gray, lineWidth: 1)
            )
            .background(Color.gray.opacity(0.2))
    }
}
