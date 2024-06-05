//
//  EpisodesDataSourceProtocol.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

struct EpisodesDataSource: EpisodesDataSourceProtocol {

    func getEpisodesResultsAndHasNextPage(for page: Int) async throws -> ([EpisodeDTO], Bool) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode/?page=\(page)") else {
            throw NetworkError.badURL
        }

        let request = URLRequest(url: url)
        let data = try await Network.shared.fetchData(this: request, of: EpisodesPaginationDTO.self)
        return (data.results, data.info.next != nil)
    }

    func getEpisodesAndHasNextPageWhenSearching(this name: String, for page: Int) async throws -> ([EpisodeDTO], Bool) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode/?name=\(name)&page=\(page)") else {
            throw NetworkError.badURL
        }
        let request = URLRequest(url: url)

        let data = try await Network.shared.fetchData(this: request, of: EpisodesPaginationDTO.self)
        return (data.results, data.info.next != nil)
    }

    func getEpisodeDetailsByURL(for url: String) async throws -> EpisodeDTO {
        guard let url = URL(string: url) else {
            throw NetworkError.badURL
        }
        let request = URLRequest(url: url)

        return try await Network.shared.fetchData(this: request, of: EpisodeDTO.self)
    }
}
