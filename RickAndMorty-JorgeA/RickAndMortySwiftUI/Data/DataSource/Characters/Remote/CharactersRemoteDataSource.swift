//
//  CharactersDataSource.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

struct CharactersRemoteDataSource: CharactersRemoteDataSourceProtocol {
    func getCharactersResultsAndHasNextPage(for page: Int) async throws -> ([CharacterDTO], Bool) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)") else {
            throw NetworkError.badURL
        }

        let request = URLRequest(url: url)

        let data = try await Network.shared.fetchData(this: request, of: CharactersPaginationDTO.self)
        return (data.results, data.info.next != nil)
    }

    func getCharactersAndHasNextPageWhenSearching(this name: String, for page: Int) async throws -> ([CharacterDTO], Bool) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?name=\(name)&page=\(page)") else {
            throw NetworkError.badURL
        }
        let request = URLRequest(url: url)
        let data = try await Network.shared.fetchData(this: request, of: CharactersPaginationDTO.self)
        return (data.results, data.info.next != nil)
    }

    func getCharacterDetailsByURL(for url: String) async throws -> CharacterDTO {
        guard let url = URL(string: url) else {
            throw NetworkError.badURL
        }
        let request = URLRequest(url: url)

        return try await Network.shared.fetchData(this: request, of: CharacterDTO.self)
    }
}
