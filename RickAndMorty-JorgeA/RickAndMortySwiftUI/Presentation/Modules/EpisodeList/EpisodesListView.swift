//
//  EpisodeListView.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 17/4/24.
//

import SwiftUI

struct EpisodesListView<VM>: View where VM: EpisodesListViewModel {
    @ObservedObject var viewModel: VM

    @State private var searchText = ""

    var body: some View {
        VStack {
            NavigationStack {
                ScrollView {
                    LazyVStack {
                        ForEach($viewModel.episodes) { $episode in
                            NavigationLink(destination:  EpisodeDetailBuilder().build(with: episode)) {
                                EpisodeCell(episode: episode)
                                    .padding(.horizontal, 20)
                                    .onAppear {
                                        if episode.id == viewModel.episodes.last?.id {
                                            if viewModel.searchText != "" {
                                                viewModel.loadEpisodesSearched(this: viewModel.searchText)
                                            } else {
                                                viewModel.loadEspisodes()
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
                .navigationTitle("Episodes")
                .navigationBarTitleDisplayMode(.inline)
                .accentColor(.black)
                .searchable(text: $viewModel.searchText)
            }
        }
        .alert("Episode list load error ", isPresented: $viewModel.errorHasOcurred) {
            Button("OK", role: .cancel) { }
        }
        .onAppear() {
            viewModel.loadEspisodes()
        }
    }
}

