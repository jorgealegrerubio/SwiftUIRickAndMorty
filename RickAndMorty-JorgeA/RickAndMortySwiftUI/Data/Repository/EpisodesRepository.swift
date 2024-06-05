//
//  EpisodesRepository.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

struct EpisodesRepository: EpisodesRepositoryProtocol {

    let episodesDataSource: EpisodesDataSourceProtocol

    init(episodesDataSource: EpisodesDataSourceProtocol) {
        self.episodesDataSource = episodesDataSource
    }

    func getEpisodesResults(for page: Int) async throws -> ([Episode], Bool) {
        let (episodesDTO, hasNextPage) = try await episodesDataSource.getEpisodesResultsAndHasNextPage(for: page)

        return (episodesDTO.map { $0.toDomain() }, hasNextPage)
    }

    func getEpisodesWhenSearching(this name: String, for page: Int) async throws -> ([Episode], Bool) {
        let (episodesDTO, hasNextPage) = try await episodesDataSource.getEpisodesAndHasNextPageWhenSearching(this: name, for: page)
        return (episodesDTO.map { $0.toDomain() }, hasNextPage)
    }

    func getEpisodeDetailsByURL(for url: String) async throws -> Episode {
        let episode = try await episodesDataSource.getEpisodeDetailsByURL(for: url)
        return episode.toDomain()
    }
}

fileprivate extension EpisodeDTO {
    func toDomain() -> Episode {
        Episode(id: self.id,
                name: self.name,
                airDate: self.airDate,
                episode: self.episode,
                characters: self.characters)
    }
}
