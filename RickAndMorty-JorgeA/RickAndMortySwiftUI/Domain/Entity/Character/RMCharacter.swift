//
//  Character.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

struct RMCharacter: Identifiable, Equatable {
    var id: Int
    let name: String
    let status: String?
    let species: String
    let type: String?
    let gender: String
    let origin: CharacterPlace?
    let location: CharacterPlace?
    let image: String
    let episode: [String]
    var isFavorite: Bool = false
}
