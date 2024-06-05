//
//  EpisodeDetailBuilder.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

class EpisodeDetailBuilder {
    func build(with episode: Episode) -> EpisodeDetailView<EpisodeDetailViewModel> {
        let charactersRemoteDataSource = CharactersRemoteDataSource()
        let charactersCacheDataSource = CharactersCacheDataSource(localManager: CacheManager())
        let charactersRepository = CharactersRepository(characterRemoteDataSource: charactersRemoteDataSource, characterCacheDataSource: charactersCacheDataSource)
        let charactersUseCase = CharacterUseCase(characterRepository: charactersRepository)

        let episodesDataSource = EpisodesDataSource()
        let episodesRepository = EpisodesRepository(episodesDataSource: episodesDataSource)
        let episodesUseCase = EpisodeUseCase(episodeRepository: episodesRepository)

        let viewModel = EpisodeDetailViewModel(episode: episode, characterUseCase: charactersUseCase, episodeUseCase: episodesUseCase)
        let view = EpisodeDetailView(viewModel: viewModel)

        return view
    }
}
