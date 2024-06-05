//
//  InfoDTO.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

struct CharactersPaginationDTO: Codable {
    let info: InfoCharactersDTO
    let results: [CharacterDTO]
}

struct InfoCharactersDTO: Codable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}
