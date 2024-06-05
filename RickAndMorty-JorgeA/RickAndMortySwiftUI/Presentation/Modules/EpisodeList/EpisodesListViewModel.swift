//
//  EpisodesListViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 17/4/24.
//

import Foundation

class EpisodesListViewModel: ObservableObject, EpisodesListViewModelProtocol {

    // MARK: Properties
    @Published var episodes: [Episode] = []
    @Published var errorHasOcurred = false
    @Published var searchText: String = "" {
        didSet {
            if !searchText.isEmpty && searchText.count > 1 {
                resetEpisodesSearched()
                Task {
                    await  loadEpisodesSearched(this: searchText)
                }
            }
            if searchText.isEmpty {
                resetEpisodesList()
            }
        }
    }

    var page = 1

    var hasNextPage: Bool = true {
        didSet {
            if hasNextPage == true {
                page += hasNextPage ? 1 : 0
            }
        }
    }

    var searchHasNextPage: Bool = true {
        didSet {
            if searchHasNextPage == true {
                page += searchHasNextPage ? 1 : 0
            }
        }
    }

    var lastVisibleIndex: Int? = nil {
        didSet {
            if lastVisibleIndex == episodes.count - 5 {
                Task {
                    await   loadEspisodes()
                }
            }
        }
    }

    var lastVisibleSearchedIndex: Int? = nil {
        didSet {
            if lastVisibleIndex == episodes.count - 5 {
                Task {
                    await  loadEpisodesSearched(this: searchText)
                }
            }
        }
    }

    let episodeUseCase: EpisodeUseCaseProtocol

    init(episodeUseCase: EpisodeUseCaseProtocol) {
        self.episodeUseCase = episodeUseCase
    }

    // MARK: API Calls
    @MainActor
    func loadEspisodes() {
        if !hasNextPage { return }
        Task {
            do {
                let (episodes, hasNextPage) = try await episodeUseCase.getEpisodesResults(for: page)

                    self.episodes.append(contentsOf: episodes)
                    self.hasNextPage = hasNextPage
                    self.lastVisibleIndex = episodes.count - 5
            } catch {
                errorHasOcurred = true
            }
        }
    }

    @MainActor
    func loadEpisodesSearched(this text: String) {
        if !searchHasNextPage { return }
        Task {
            do {
                let (episodes, searchHasNextPage) = try await episodeUseCase.getEpisodesWhenSearching(this: text, for: page)

                    self.episodes.append(contentsOf: episodes)
                    self.searchHasNextPage = searchHasNextPage
                    self.lastVisibleSearchedIndex = episodes.count - 5
            } catch {
                errorHasOcurred = true
            }
        }
    }

    // MARK: Functions
    func resetEpisodesList() {
        episodes.removeAll()
        hasNextPage = true
        page = 1
        Task {
            await loadEspisodes()
        }
    }

    func resetEpisodesSearched() {
        episodes.removeAll()
        searchHasNextPage = true
        page = 1
    }
}
