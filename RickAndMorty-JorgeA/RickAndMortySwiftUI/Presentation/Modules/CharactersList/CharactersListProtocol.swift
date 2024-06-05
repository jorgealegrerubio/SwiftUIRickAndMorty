//
//  CharactersProtocol.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

protocol CharactersListViewModelProtocol {
    var characters: [RMCharacter] { get set }
    var errorHasOcurred: Bool { get }
    var searchText: String { get set }
    var hasNextPage: Bool { get set }
    var searchHasNextPage: Bool { get set }
    var lastVisibleIndex: Int? { get set }
    var lastVisibleSearchedIndex: Int? { get set }
    func loadCharacters() async
    func loadCharactersSearched(this text: String) async
    func resetCharactersList()
    func resetCharactersSearched()
    func addOrRemove(this character: RMCharacter)
}
