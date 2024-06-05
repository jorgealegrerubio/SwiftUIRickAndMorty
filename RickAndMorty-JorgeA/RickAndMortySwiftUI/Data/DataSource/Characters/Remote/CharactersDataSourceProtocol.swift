//
//  CharactersDataSourceProtocol.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

protocol CharactersRemoteDataSourceProtocol {
    func getCharactersResultsAndHasNextPage(for page: Int) async throws -> ([CharacterDTO], Bool)
    func getCharactersAndHasNextPageWhenSearching(this name: String, for page: Int) async throws -> ([CharacterDTO], Bool)
    func getCharacterDetailsByURL(for url: String) async throws -> CharacterDTO
}
