//
//  EpisodeDetailViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

class EpisodeDetailViewModel: ObservableObject, EpisodeDetailViewModelProtocol {
    // MARK: Properties
    @Published var episode: Episode
    @Published var errorHasOcurred = false
    @Published var relatedCharacters: [RMCharacter] = []
    @Published var isEpisodeDetailFirstLoad: Bool = true

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
                loadRelatedCharacters()
            }
        }
    }

    let characterUseCase: CharacterUseCaseProtocol
    let episodeUseCase: EpisodeUseCaseProtocol

    init(episode: Episode, characterUseCase: CharacterUseCaseProtocol, episodeUseCase: EpisodeUseCaseProtocol) {
        self.episode = episode
        self.characterUseCase = characterUseCase
        self.episodeUseCase = episodeUseCase
    }

    // MARK: API Calls
    @MainActor
    func getRelatedCharacters(characterURL: String) {
        Task {
            do {
                let relatedCharacter = try await characterUseCase.getEpisodeDetailsByURL(for: characterURL)
                    self.relatedCharacters.append(relatedCharacter)
            } catch {
                errorHasOcurred = true
            }
        }
    }

    // MARK: Functions

    func loadRelatedCharacters() {
        episode.characters.forEach { character in
            Task {
                await  getRelatedCharacters(characterURL: character)
            }
        }
    }
}
