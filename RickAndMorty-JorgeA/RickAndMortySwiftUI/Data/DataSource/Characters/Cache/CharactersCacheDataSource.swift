//
//  CharactersCacheDataSource.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 17/4/24.
//

import Foundation

class CharactersCacheDataSource: CharactersCacheDataSourceProtocol {
    var localManager: LocalManagerProtocol
    var favoritesKey = "favorites"

    init(localManager: LocalManagerProtocol) {
        self.localManager = localManager
    }

    func getFavorites() async throws -> [CharacterDTO] {
        guard let favorites = localManager.retrieve(objectFor: favoritesKey, of: [CharacterDTO].self ) else { return [] }

        return favorites
    }

    func saveFavorite(_ character: CharacterDTO) async throws {
        var favorites = try await self.getFavorites()
        favorites.removeAll(where: {$0.id == character.id})
        favorites.append(character)

        localManager.save(objectFor: favoritesKey, this: favorites)
    }

    func removeFavorite(_ character: CharacterDTO) async throws {
        var favorites = try await self.getFavorites()
        favorites.removeAll(where: {$0.id == character.id})

        localManager.save(objectFor: favoritesKey, this: favorites)
    }
}
