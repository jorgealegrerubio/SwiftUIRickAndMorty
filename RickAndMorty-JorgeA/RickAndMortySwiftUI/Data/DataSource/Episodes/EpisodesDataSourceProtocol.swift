//
//  EpisodesDataSource.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

protocol EpisodesDataSourceProtocol {
    func getEpisodesResultsAndHasNextPage(for page: Int) async throws -> ([EpisodeDTO], Bool)
    func getEpisodesAndHasNextPageWhenSearching(this name: String, for page: Int) async throws -> ([EpisodeDTO], Bool)
    func getEpisodeDetailsByURL(for url: String) async throws -> EpisodeDTO
}
