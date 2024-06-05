//
//  CharacterDetailViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

import Foundation

class CharacterDetailViewModel: ObservableObject, CharacterDetailViewModelProtocol {
    // MARK: Properties
    @Published var character: RMCharacter
    @Published var errorHasOcurred = false
    @Published var relatedCharacters: [RMCharacter] = []
    @Published var relatedEpisodes: [Episode] = []

    @Published var isRelatedCharactersSelected: Bool = true
    @Published var isEpisodesSelected: Bool = false
    @Published var isFirstLoad: Bool = true

    var page = 1

    var searchHasNextPage: Bool = true {
        didSet {
            if searchHasNextPage == true {
                page += searchHasNextPage ? 1 : 0
            }
        }
    }

    var lastVisibleIndex: Int? = nil {
        didSet {
            if lastVisibleIndex == relatedCharacters.count - 5 {
                Task {
                    await loadRelatedCharacters()
                }
            }
        }
    }

    let characterUseCase: CharacterUseCaseProtocol
    let episodeUseCase: EpisodeUseCaseProtocol

    init(character: RMCharacter, characterUseCase: CharacterUseCaseProtocol, episodeUseCase: EpisodeUseCaseProtocol) {
        self.character = character
        self.characterUseCase = characterUseCase
        self.episodeUseCase = episodeUseCase
    }

    // MARK: API Calls
    @MainActor
    func loadRelatedCharacters() {
        if !searchHasNextPage { return }
        Task {
            do {
                let name = character.name.split(separator: " ")
                guard let firstName = name.first else { return }

                let (relatedCharacters, searchHasNextPage) = try await characterUseCase.getCharactersAndHasNextPageWhenSearching(this: String(firstName), for: page)

                self.relatedCharacters.append(contentsOf: relatedCharacters)
                print(self.relatedCharacters)
                self.searchHasNextPage = searchHasNextPage
                self.lastVisibleIndex = relatedCharacters.count - 5
            } catch {
                errorHasOcurred = true
            }
        }
    }

    @MainActor
    func getRelatedEpisodes(episodeURL: String) {
        Task {
            do {
                let relatedEpisode = try await episodeUseCase.getEpisodeDetailsByURL(for: episodeURL)

                self.relatedEpisodes.append(relatedEpisode)

            } catch {
                errorHasOcurred = true
            }
        }
    }

    // MARK: Functions

    func loadRelatedEpisodes() {
        character.episode.forEach { episode in
            Task {
                await getRelatedEpisodes(episodeURL: episode)
            }
        }
    }

    func resetRelatedCharacters() {
        relatedCharacters.removeAll()
        searchHasNextPage = true
        page = 1
    }

    func resetRelatedEpisodes() {
        relatedEpisodes.removeAll()
    }
}
