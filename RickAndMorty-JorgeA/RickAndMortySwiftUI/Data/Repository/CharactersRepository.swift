//
//  CharactersRepository.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

struct CharactersRepository: CharactersRepositoryProtocol {

    let characterRemoteDataSource: CharactersRemoteDataSourceProtocol
    let characterCacheDatasource: CharactersCacheDataSourceProtocol

    init(characterRemoteDataSource: CharactersRemoteDataSourceProtocol, characterCacheDataSource: CharactersCacheDataSourceProtocol) {
        self.characterRemoteDataSource = characterRemoteDataSource
        self.characterCacheDatasource = characterCacheDataSource
    }

    func getCharactersResults(for page: Int) async throws -> ([RMCharacter], Bool) {
        let (charactersDTO, hasNextPage) = try await characterRemoteDataSource.getCharactersResultsAndHasNextPage(for: page)
        return (charactersDTO.map { $0.toDomain()}, hasNextPage)
    }

    func getCharactersWhenSearching(this name: String, for page: Int) async throws -> ([RMCharacter], Bool) {
        let (charactersDTO, hasNextPage) = try await characterRemoteDataSource.getCharactersAndHasNextPageWhenSearching(this: name, for: page)
        return (charactersDTO.map { $0.toDomain()}, hasNextPage)
    }

    func getEpisodeDetailsByURL(for url: String) async throws -> RMCharacter {
        let character = try await characterRemoteDataSource.getCharacterDetailsByURL(for: url)
        return character.toDomain()
    }
    
    func getFavorites() async throws -> [RMCharacter] {
        let favorites = try await characterCacheDatasource.getFavorites()
        return favorites.map { $0.toDomain() }
    }

    func saveFavorite(_ character: RMCharacter) async throws {
        try await characterCacheDatasource.saveFavorite(character.toData())
    }

    func removeFavorite(_ character: RMCharacter) async throws {
        try await characterCacheDatasource.removeFavorite(character.toData())
    }
}

fileprivate extension CharacterDTO {
    func toDomain() -> RMCharacter {
        RMCharacter(id: self.id,
                  name: self.name,
                  status: self.status,
                  species: self.species,
                  type: self.type,
                  gender: self.gender,
                  origin: self.origin?.toDomain(),
                  location: self.location?.toDomain(),
                  image: self.image,
                  episode: self.episode)
    }
}

fileprivate extension CharacterPlaceDTO {
    func toDomain() -> CharacterPlace {
        CharacterPlace(name: self.name,
                       url: self.url)
    }
}

fileprivate extension RMCharacter {
    func toData() -> CharacterDTO {
        CharacterDTO(id: self.id,
                     name: self.name ,
                     status: self.status,
                     species: self.species,
                     type: self.type,
                     gender: self.gender,
                     origin: self.origin?.toData(),
                     location: self.location?.toData(),
                     image: self.image,
                     episode: self.episode)
    }
}

fileprivate extension CharacterPlace {
    func toData() -> CharacterPlaceDTO {
        CharacterPlaceDTO(name: self.name,
                          url: self.url)
    }
}
