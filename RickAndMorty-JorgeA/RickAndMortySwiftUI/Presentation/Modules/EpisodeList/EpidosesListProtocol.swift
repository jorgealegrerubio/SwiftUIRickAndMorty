//
//  EpidosesListProtocol.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 17/4/24.
//

import Foundation

protocol EpisodesListViewModelProtocol: ObservableObject {
    var episodes: [Episode] { get set }
    var errorHasOcurred: Bool { get }
    var searchText: String { get set }
    var hasNextPage: Bool { get set }
    var searchHasNextPage: Bool { get set }
    var lastVisibleIndex: Int? { get set }
    var lastVisibleSearchedIndex: Int? { get set }
    func loadEspisodes() async
    func loadEpisodesSearched(this text: String) async
    func resetEpisodesList()
    func resetEpisodesSearched()
}
