//
//  FavoritesBuilder.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 17/4/24.
//

import Foundation

class FavoritesBuilder {
    func build() -> FavoritesView<FavoritesViewModel> {
        let networkDataSource = CharactersRemoteDataSource()
        let cacheDataSource = CharactersCacheDataSource(localManager: CacheManager())
        let repository = CharactersRepository(characterRemoteDataSource: networkDataSource,
                                              characterCacheDataSource: cacheDataSource)
        let useCase = CharacterUseCase(characterRepository: repository)

        let viewModel = FavoritesViewModel(useCase: useCase)
        let view = FavoritesView(viewModel: viewModel)
        return view
    }
}
