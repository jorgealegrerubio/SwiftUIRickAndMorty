//
//  CharacterDetailBuilder.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

class CharacterDetailBuilder {
    func build(with character: RMCharacter) -> CharacterDetailView<CharacterDetailViewModel> {
        let charactersRemoteDataSource = CharactersRemoteDataSource()
        let charactersCacheDataSource = CharactersCacheDataSource(localManager: CacheManager())
        let charactersRepository = CharactersRepository(characterRemoteDataSource: charactersRemoteDataSource, characterCacheDataSource: charactersCacheDataSource)
        let charactersUseCase = CharacterUseCase(characterRepository: charactersRepository)

        let episodesDataSource = EpisodesDataSource()
        let episodesRepository = EpisodesRepository(episodesDataSource: episodesDataSource)
        let episodesUseCase = EpisodeUseCase(episodeRepository: episodesRepository)

        let viewModel = CharacterDetailViewModel(character: character, characterUseCase: charactersUseCase, episodeUseCase: episodesUseCase)
        let view = CharacterDetailView(viewModel: viewModel)

        return view
    }
}
