//
//  RelatedCharacterCell.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 17/4/24.
//

import SwiftUI

struct RelatedCharacterCell: View {
    var character: RMCharacter

    var body: some View {
        HStack {
            if let imageURL = URL(string: character.image) {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                        .frame(width: 60, height: 60, alignment: .center)
                        .foregroundColor(.white)
                        .background(.gray)
                        .opacity(0.5)
                        .clipShape(Circle())

                }
            }

            Text(character.name)
                .frame(minWidth: 100, alignment: .leading)
            Spacer()
        }
        .padding(4)
        .background(.gray.opacity(0.2))
        .cornerRadius(6)
    }
}
