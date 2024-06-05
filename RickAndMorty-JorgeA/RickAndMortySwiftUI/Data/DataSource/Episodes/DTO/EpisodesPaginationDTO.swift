//
//  PaginationDTO.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 17/4/24.
//

import Foundation

struct EpisodesPaginationDTO: Codable {
    let info: InfoEpisodesDTO
    let results: [EpisodeDTO]
}

struct InfoEpisodesDTO: Codable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}
