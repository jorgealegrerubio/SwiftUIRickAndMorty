//
//  Episode.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

struct Episode: Identifiable {
    var id: Int
    let name: String
    let airDate: String?
    let episode: String
    let characters: [String]
}
