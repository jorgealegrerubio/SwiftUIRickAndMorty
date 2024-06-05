//
//  EpidoseUseCase.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

struct EpisodeUseCase: EpisodeUseCaseProtocol {

    let episodeRepository: EpisodesRepositoryProtocol

    init(episodeRepository: EpisodesRepositoryProtocol) {
        self.episodeRepository = episodeRepository
    }

    func getEpisodesResults(for page: Int) async throws -> ([Episode], Bool) {
        let (episodes, hasNextPage) = try await episodeRepository.getEpisodesResults(for: page)

        return (episodes, hasNextPage)
    }

    func getEpisodesWhenSearching(this name: String, for page: Int) async throws -> ([Episode], Bool) {
        let (episodes, hasNextPage) = try await episodeRepository.getEpisodesWhenSearching(this: name, for: page)

        return (episodes, hasNextPage)
    }

    func getEpisodeDetailsByURL(for url: String) async throws -> Episode {
        let episode = try await episodeRepository.getEpisodeDetailsByURL(for: url)
        return episode
    }
}
