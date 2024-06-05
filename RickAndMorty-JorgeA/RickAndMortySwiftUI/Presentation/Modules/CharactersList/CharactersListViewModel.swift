//
//  CharacterViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

class CharactersListViewModel: ObservableObject, CharactersListViewModelProtocol {
    // MARK: Properties
    @Published var characters: [RMCharacter] = []
    @Published var errorHasOcurred = false

    @Published var searchText: String = "" {
        didSet {
            if !searchText.isEmpty && searchText.count > 1 {
                resetCharactersSearched()
                Task {
                    await loadCharactersSearched(this: searchText)
                }
            }
            if searchText.isEmpty {
                Task {
                    await resetCharactersList()
                }
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
            if lastVisibleIndex == characters.count - 5 {
                Task {
                    await loadCharacters()
                }
            }
        }
    }

    var lastVisibleSearchedIndex: Int? = nil {
        didSet {
            if lastVisibleIndex == characters.count - 5 {
                Task {
                    await loadCharactersSearched(this: searchText)
                }

            }
        }
    }

    let characterUseCase: CharacterUseCaseProtocol

    init(characterUseCase: CharacterUseCaseProtocol) {
        self.characterUseCase = characterUseCase
    }

    // MARK: API Calls
    @MainActor
    func loadCharacters() {
        if !hasNextPage { return }
        Task {
            do {
                let (characters, hasNextPage) = try await characterUseCase.getCharactersResultsAndHasNextPage(for: page)
                self.characters.append(contentsOf: characters)
                self.hasNextPage = hasNextPage
                self.lastVisibleIndex = characters.count - 5
            } catch {
                errorHasOcurred = true
            }
        }
    }

    // MARK: Functions
    @MainActor
    func addOrRemove(this character: RMCharacter) {
        Task {
            if character.isFavorite {
                try await self.characterUseCase.saveFavorite(character)
            } else {
                try await self.characterUseCase.removeFavorite(character)
            }
        }
    }

    @MainActor
    func loadCharactersSearched(this text: String) {
        if !searchHasNextPage { return }
        Task {
            do {
                let (characters, searchHasNextPage) = try await characterUseCase.getCharactersAndHasNextPageWhenSearching(this: text, for: page)
                self.characters.append(contentsOf: characters)
                self.searchHasNextPage = searchHasNextPage
                self.lastVisibleSearchedIndex = characters.count - 5
            } catch {
                errorHasOcurred = true
            }
        }
    }
    
    @MainActor
    func resetCharactersList() {
        characters.removeAll()
        hasNextPage = true
        page = 1
        loadCharacters()
    }

    func resetCharactersSearched() {
        characters.removeAll()
        searchHasNextPage = true
        page = 1
    }
}
