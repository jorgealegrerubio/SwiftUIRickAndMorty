//
//  EpisodeDetailProtocol.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

protocol EpisodeDetailViewModelProtocol: ObservableObject {
    var episode: Episode { get set }
    var errorHasOcurred: Bool { get }
    var relatedCharacters: [RMCharacter] { get set }
    var isEpisodeDetailFirstLoad: Bool { get set }
    func getRelatedCharacters(characterURL: String) async
    func loadRelatedCharacters() async
}
