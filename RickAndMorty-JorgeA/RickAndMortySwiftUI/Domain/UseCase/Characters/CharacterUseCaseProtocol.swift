//
//  CharacterUseCaseProtocol.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

protocol CharacterUseCaseProtocol {
    func getCharactersResultsAndHasNextPage(for page: Int) async throws -> ([RMCharacter], Bool)
    func getCharactersAndHasNextPageWhenSearching(this name: String, for page: Int) async throws -> ([RMCharacter], Bool)
    func getEpisodeDetailsByURL(for url: String) async throws -> RMCharacter
    func getFavorites() async throws -> [RMCharacter]
    func saveFavorite(_ character: RMCharacter) async throws
    func removeFavorite(_ character: RMCharacter) async throws
    func setFavorites(to characters: [RMCharacter]) async throws -> [RMCharacter]
}
