//
//  CharacterCell.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import SwiftUI

enum Status: String {
    case Dead
    case Alive
    case unknown
}

enum Gender: String {
    case Male
    case Female
    case unknown
}

struct CharacterCellView: View {
    @Binding var character: RMCharacter

    var body: some View {
        HStack {
            ZStack {
                if let imageURL = URL(string: character.image) {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .top)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .transition(.scale(scale: 0.1, anchor: .center))
                    } placeholder: {
                        ProgressView()
                            .frame(width: 80, height: 80, alignment: .center)
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())
                    }
                }
                Circle()
                    .strokeBorder(Color.white,lineWidth: 2)
                    .background(Circle().foregroundColor(getStatusColor(for: Status(rawValue: character.status!) ?? .unknown)))
                    .frame(width: 25, height: 25)
                    .offset(x: 27, y: 27)
            }
            VStack(alignment: .leading) {
                Text(character.name).font(.headline).foregroundColor(.black)
                Image(getGenderType(for: Gender(rawValue: character.gender) ?? .unknown))
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(character.species).font(.subheadline).foregroundColor(.black)
            }
            Spacer()
            Button {
                character.isFavorite.toggle()
            } label: {
                Image(systemName: character.isFavorite ? "star.fill" : "star")
                    .foregroundColor(.black)
                    .frame(width: 24, height: 24)
            }
        }
        .frame(maxWidth: .infinity)
    }

    func getStatusColor(for status: Status) -> Color {
        switch status {
            case .Dead:
                return .red
            case .Alive:
                return .green
            case .unknown:
                return .gray
        }
    }

    func getGenderType(for gender: Gender) -> String {
        switch gender {
            case .Male:
                return gender.rawValue.lowercased()
            case .Female:
                return gender.rawValue.lowercased()
            case .unknown:
                return gender.rawValue.lowercased()
        }

    }
}
