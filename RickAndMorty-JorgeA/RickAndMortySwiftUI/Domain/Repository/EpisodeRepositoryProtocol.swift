//
//  EpisodeRepositoryProtocol.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

protocol EpisodesRepositoryProtocol {
    func getEpisodesResults(for page: Int) async throws -> ([Episode], Bool)
    func getEpisodesWhenSearching(this name: String, for page: Int) async throws -> ([Episode], Bool)
    func getEpisodeDetailsByURL(for url: String) async throws -> Episode
}
