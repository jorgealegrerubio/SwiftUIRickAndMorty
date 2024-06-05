//
//  FavoritesViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 17/4/24.
//

import Foundation

class FavoritesViewModel: ObservableObject, FavoritesViewModelProtocol {
    @Published var characters: [RMCharacter] = []
    @Published var errorOccurred: Bool = false

    var useCase: CharacterUseCaseProtocol!

    init(useCase: CharacterUseCaseProtocol) {
        self.useCase = useCase
    }

    @MainActor
    func load() async {
        do {
            let characters = try await useCase.getFavorites()
            let favorites = try await useCase.setFavorites(to: characters)
            self.characters = favorites
        } catch {
            errorOccurred = true
        }
    }

    func addOrRemove(this character: RMCharacter) {
        Task {
            if character.isFavorite {
                try await self.useCase.saveFavorite(character)
            } else {
                try await self.useCase.removeFavorite(character)
            }
            await load()
        }
    }
}
