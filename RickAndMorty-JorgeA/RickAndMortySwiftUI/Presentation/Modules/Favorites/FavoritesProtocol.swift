//
//  FavoritesProtocol.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 17/4/24.
//

import Foundation

protocol FavoritesViewModelProtocol: ObservableObject  {
    var characters: [RMCharacter] { get set }
    var errorOccurred: Bool { get set }
    func load() async
    func addOrRemove(this character: RMCharacter)
}
