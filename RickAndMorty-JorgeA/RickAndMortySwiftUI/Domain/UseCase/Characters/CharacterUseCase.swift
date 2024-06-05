//
//  CharacterUseCase.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

struct CharacterUseCase: CharacterUseCaseProtocol {

    let characterRepository: CharactersRepositoryProtocol

    init(characterRepository: CharactersRepositoryProtocol) {
        self.characterRepository = characterRepository
    }

    func getCharactersResultsAndHasNextPage(for page: Int) async throws -> ([RMCharacter], Bool) {
        let (charactersList, hasNextPage) = try await characterRepository.getCharactersResults(for: page)
        let charactersWithFavorite = try await self.setFavorites(to: charactersList)
        return (charactersWithFavorite, hasNextPage)
    }

    func getCharactersAndHasNextPageWhenSearching(this name: String, for page: Int) async throws -> ([RMCharacter], Bool) {
        let (charactersList, hasNextPage) = try await characterRepository.getCharactersWhenSearching(this: name, for: page)
        let charactersWithFavorite = try await self.setFavorites(to: charactersList)

        return (charactersWithFavorite, hasNextPage)
    }

    func getEpisodeDetailsByURL(for url: String) async throws -> RMCharacter {
        let character = try await characterRepository.getEpisodeDetailsByURL(for: url)
        return character
    }

    func getFavorites() async throws -> [RMCharacter] {
        try await characterRepository.getFavorites()
    }

    func saveFavorite(_ character: RMCharacter) async throws {
        try await characterRepository.saveFavorite(character)
    }

    func removeFavorite(_ character: RMCharacter) async throws {
        try await characterRepository.removeFavorite(character)
    }

    func setFavorites(to characters: [RMCharacter]) async throws -> [RMCharacter] {
        var charactersWithFavorites: [RMCharacter] = []
        let favorites = try await self.getFavorites()
        for var character in characters {
            character.isFavorite = favorites.contains(where: {$0.id == character.id}) ? true : false
            charactersWithFavorites.append(character)
        }
        return charactersWithFavorites
    }
}
