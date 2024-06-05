//
//  CharacterDetailProtocols.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

protocol CharacterDetailViewModelProtocol {
    var character: RMCharacter { get set }
    var relatedCharacters: [RMCharacter] { get set }
    var relatedEpisodes: [Episode] { get set }
    var errorHasOcurred: Bool { get }
    var isRelatedCharactersSelected: Bool { get set }
    var isEpisodesSelected: Bool { get set }
    var isFirstLoad: Bool { get set }
    func loadRelatedCharacters() async
    func getRelatedEpisodes(episodeURL: String) async
    func loadRelatedEpisodes() async
}
