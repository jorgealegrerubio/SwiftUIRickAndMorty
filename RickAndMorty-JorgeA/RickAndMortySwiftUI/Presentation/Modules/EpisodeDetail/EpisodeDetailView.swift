//
//  EpisodeDetailView.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import SwiftUI

struct EpisodeDetailView<VM>: View where VM: EpisodeDetailViewModel {
    @ObservedObject var viewModel: VM

    var body: some View {
        VStack {
            VStack {
                VStack (spacing: 4) {
                    Text("Episode:")
                        .foregroundColor(.blue.opacity(0.75))
                        .font(.system(size: 20).bold())
                    Text(viewModel.episode.episode)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 24)
                        .font(.system(size: 18))
                        .padding(4)
                        .foregroundColor(.black)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.gray, lineWidth: 1)
                )
                .padding(8)
                VStack (spacing: 4) {
                    Text("Air date:")
                        .foregroundColor(.blue.opacity(0.75))
                        .font(.system(size: 20).bold())
                    Text(viewModel.episode.airDate ?? "unkown")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 24)
                        .font(.system(size: 18))
                        .padding(4)
                        .foregroundColor(.black)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.gray, lineWidth: 1)
                )
                .padding(8)
            }
            VStack (spacing: 8) {
                Text("Characters:")
                    .foregroundColor(.blue.opacity(0.75))
                    .font(.system(size: 20).bold())
                ScrollView {
                    ForEach($viewModel.relatedCharacters) { $character in
                        NavigationLink(destination:  CharacterDetailBuilder().build(with: character)) {
                            RelatedCharacterCell(character: character)
                                .padding(.horizontal, 8)
                        }
                    }
                }

            }
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.gray, lineWidth: 1)
            )
            .padding(8)
            .frame(maxHeight: .infinity)
            .onAppear() {
                if viewModel.isEpisodeDetailFirstLoad == true {
                    viewModel.loadRelatedCharacters()
                    viewModel.isEpisodeDetailFirstLoad = false
                }
            }

        }
        .alert("Episode detail load error ", isPresented: $viewModel.errorHasOcurred) {
            Button("OK", role: .cancel) { }
        }
        .navigationTitle(viewModel.episode.name)
    }
}
