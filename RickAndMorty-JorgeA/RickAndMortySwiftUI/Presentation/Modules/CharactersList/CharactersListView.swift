//
//  CharacterView.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import SwiftUI

struct CharactersListView<VM>: View where VM: CharactersListViewModel {

    @ObservedObject var viewModel: VM

    @State private var searchText = ""

    var body: some View {
        VStack {
            NavigationStack {
                ScrollView {
                    LazyVStack {
                        ForEach($viewModel.characters) { $character in
                            NavigationLink(destination:  CharacterDetailBuilder().build(with: character)) {
                                CharacterCellView(character: $character)
                                    .padding(.horizontal, 20)
                                    .onAppear {
                                        if (viewModel.characters.last?.id) != nil {
                                            if character.id == viewModel.characters.last?.id {
                                                if viewModel.searchText != "" {
                                                    viewModel.loadCharactersSearched(this: viewModel.searchText)
                                                } else {
                                                    viewModel.loadCharacters()
                                                }
                                            }
                                        }
                                    }

                            }
                            .onChange(of: character, { oldValue, newValue in
                                viewModel.addOrRemove(this: newValue)
                            })
                        }
                    }
                }
                .navigationTitle("Characters")
                .navigationBarTitleDisplayMode(.inline)
                .accentColor(.black)
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            }
        }
        .onAppear() {
            viewModel.resetCharactersList()
        }
        .alert("Characters load error ", isPresented: $viewModel.errorHasOcurred) {
            Button("OK", role: .cancel) { }
        }
    }
}
