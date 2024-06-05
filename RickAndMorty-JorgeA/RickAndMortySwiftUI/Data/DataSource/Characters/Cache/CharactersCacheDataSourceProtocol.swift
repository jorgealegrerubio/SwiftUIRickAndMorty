//
//  CharactersCacheDataSourceProtocol.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 17/4/24.
//

import Foundation

protocol CharactersCacheDataSourceProtocol {
    func getFavorites() async throws -> [CharacterDTO]
    func saveFavorite(_ character: CharacterDTO)  async throws
    func removeFavorite(_ character: CharacterDTO)  async throws
}
