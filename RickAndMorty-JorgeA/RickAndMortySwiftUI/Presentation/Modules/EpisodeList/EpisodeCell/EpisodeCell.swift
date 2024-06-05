//
//  EpisodeCell.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 17/4/24.
//

import SwiftUI

struct EpisodeCell: View {
    var episode: Episode

    var body: some View {
        HStack {
            Text(episode.episode)
                .font(.system(size: 14))
            Divider()
                .frame(width: 1)
            Text(episode.name)
                .font(.system(size: 18))
                .lineLimit(nil)
                .foregroundColor(.blue.opacity(0.75))
                .multilineTextAlignment(.leading)
            Spacer()
            Divider()
                .frame(width: 1)
            Text(episode.airDate ?? "")
                .frame(width: 80, alignment: .leading)
                .font(.system(size: 14))
                .lineLimit(nil)

        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
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
