//
//  CharacterDetail.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import SwiftUI

struct CharacterDetailView<VM>: View where VM: CharacterDetailViewModel {
    @ObservedObject var viewModel: VM

    var body: some View {
        ScrollView {
            VStack {
                if let url = URL(string: viewModel.character.image) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                }
                VStack {
                    VStack (spacing: 4) {
                        Text("Last known location:")
                            .foregroundColor(.blue.opacity(0.75))
                            .font(.system(size: 20).bold())
                        Text(viewModel.character.location?.name ?? "unkown")
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

                    VStack (spacing: 4) {
                        Text("First seen in:")
                            .foregroundColor(.blue.opacity(0.75))
                            .font(.system(size: 20).bold())
                        Text(viewModel.character.origin?.name ?? "unkown")
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
                }
                .padding(.horizontal, 8)

                HStack {
                    Text("Related characters")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 24)
                        .font(.system(size: 18))
                        .padding(4)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .background(viewModel.isRelatedCharactersSelected == true ? .gray.opacity(0.4) : .clear)
                        .cornerRadius(6)
                        .onTapGesture {
                            viewModel.isRelatedCharactersSelected = true
                            viewModel.isEpisodesSelected = false
                            viewModel.resetRelatedCharacters()
                            viewModel.loadRelatedCharacters()
                            print("List of related characters")
                        }
                    Text("Episodes")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 24)
                        .font(.system(size: 18))
                        .padding(4)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .background(viewModel.isEpisodesSelected == true ? .gray.opacity(0.4) : .clear)
                        .cornerRadius(6)
                        .onTapGesture {
                            viewModel.isRelatedCharactersSelected = false
                            viewModel.isEpisodesSelected = true
                            viewModel.resetRelatedEpisodes()
                            viewModel.loadRelatedEpisodes()
                            print("List of episodes")
                        }
                }
                .padding(.horizontal, 8)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        if viewModel.isRelatedCharactersSelected {
                            ForEach($viewModel.relatedCharacters) { $character in
                                NavigationLink(destination:  CharacterDetailBuilder().build(with: character)) {
                                    RelatedCharacterRow(character: character)
                                        .padding(.vertical, 20)
                                        .onAppear() {
                                            if character.id == viewModel.relatedCharacters.last?.id {
                                                viewModel.loadRelatedCharacters()
                                                viewModel.isFirstLoad = false
                                            }
                                        }
                                }
                            }
                        } else if viewModel.isEpisodesSelected {
                            ForEach($viewModel.relatedEpisodes) { $episode in
                                NavigationLink(destination:  EpisodeDetailBuilder().build(with: episode)) {
                                    RelatedEpisodesRow(episodeText: episode.episode)
                                        .padding(.vertical, 20)
                                }
                            }
                        }
                    }
                    .padding(16)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .onAppear() {
                    if viewModel.isFirstLoad == true {
                        viewModel.loadRelatedCharacters()
                        viewModel.loadRelatedEpisodes()
                    }
                }
            }
            .alert("Character detail load error ", isPresented: $viewModel.errorHasOcurred) {
                Button("OK", role: .cancel) { }
            }
            .navigationTitle(viewModel.character.name)
        }
    }
}
