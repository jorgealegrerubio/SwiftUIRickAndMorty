//
//  CharactersUseCaseTests.swift
//  RickAndMortySwiftUITests
//
//  Created by Jorge on 17/4/24.
//

import XCTest
@testable import RickAndMortySwiftUI

final class CharacterUseCaseTests: XCTestCase {
    var sutCharacterUseCase: CharacterUseCase!
    var repository: CharactersRepositoryFake!

    override func setUp() {
        super.setUp()

        repository = CharactersRepositoryFake()
        sutCharacterUseCase = CharacterUseCase(characterRepository: repository)
    }

    override func tearDown() {
        super.tearDown()

        repository = nil
        sutCharacterUseCase = nil
    }

    func test_getCharactersResults_Success() async {
        do {
            let (results, _) = try await sutCharacterUseCase.getCharactersResultsAndHasNextPage(for: 0)
            XCTAssertEqual(results.count, 1)
        } catch {
            XCTFail("It would be successful")
        }
    }

    func test_getCharactersAndHasNextPageWhenSearching() async {
        do {
            let (results, _) = try await sutCharacterUseCase.getCharactersAndHasNextPageWhenSearching(this: "Rick", for: 0)
            XCTAssertEqual(results.count, 1)
        } catch {
            XCTFail("It would be successful")
        }
    }

    func test_getEpisodeDetailsByUR() async {
        do {
            let character = try await sutCharacterUseCase.getEpisodeDetailsByURL(for: "Rick")
            XCTAssertEqual(character.name, "Rick")
        } catch {
            XCTFail("It would be successful")
        }
    }
}
