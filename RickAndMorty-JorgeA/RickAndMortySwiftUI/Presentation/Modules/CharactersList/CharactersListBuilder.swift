//
//  CharactersBuilder.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

class CharactersListBuilder {
    func build() -> CharactersListView<CharactersListViewModel> {
        let charactersRemoteDataSource = CharactersRemoteDataSource()
        let charactersCacheDataSource = CharactersCacheDataSource(localManager: CacheManager())
        let charactersRepository = CharactersRepository(characterRemoteDataSource: charactersRemoteDataSource, characterCacheDataSource: charactersCacheDataSource)
        let charactersUseCase = CharacterUseCase(characterRepository: charactersRepository)

        let viewModel = CharactersListViewModel(characterUseCase: charactersUseCase)
        let view = CharactersListView(viewModel: viewModel)

        return view
    }
}
