//
//  EpidoseListBuilder.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 17/4/24.
//

import Foundation

class EpisodesListBuilder {
    func build() -> EpisodesListView<EpisodesListViewModel> {
        let episodesDataSource = EpisodesDataSource()
        let episodesRepository = EpisodesRepository(episodesDataSource: episodesDataSource)
        let episodesUseCase = EpisodeUseCase(episodeRepository: episodesRepository)

        let viewModel = EpisodesListViewModel(episodeUseCase: episodesUseCase)
        let view = EpisodesListView(viewModel: viewModel)

        return view
    }
}
