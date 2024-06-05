//
//  CharacterRepositoryFake.swift
//  RickAndMortySwiftUITests
//
//  Created by Jorge on 17/4/24.
//

import Foundation
@testable import RickAndMortySwiftUI

final class CharactersRepositoryFake: CharactersRepositoryProtocol {
    func getCharactersResults(for page: Int) async throws -> ([RMCharacter], Bool) {
        return  ([RMCharacter(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: CharacterPlace(name: "", url: ""), location: CharacterPlace(name: "", url: ""), image: "", episode: [])], true)
    }

    func getCharactersWhenSearching(this name: String, for page: Int) async throws -> ([RMCharacter], Bool) {
        return ([RMCharacter(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: CharacterPlace(name: "", url: ""), location: CharacterPlace(name: "", url: ""), image: "", episode: [])], true)
    }

    func getEpisodeDetailsByURL(for url: String) async throws -> RMCharacter {
        return RMCharacter(id: 1, name: "Rick", status: "", species: "", type: "", gender: "", origin: CharacterPlace(name: "", url: ""), location: CharacterPlace(name: "", url: ""), image: "", episode: [])
    }

    func getFavorites() async throws -> [RMCharacter] {
        return [RMCharacter(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: CharacterPlace(name: "", url: ""), location: CharacterPlace(name: "", url: ""), image: "", episode: [])]
    }

    func saveFavorite(_ character: RMCharacter) async throws {
    }

    func removeFavorite(_ character: RMCharacter) async throws {
    }
}
