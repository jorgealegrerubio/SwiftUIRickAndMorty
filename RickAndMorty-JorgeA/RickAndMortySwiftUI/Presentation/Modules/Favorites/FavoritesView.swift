//
//  FavoritesView.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 17/4/24.
//

import SwiftUI

struct FavoritesView<VM>: View where VM: FavoritesViewModelProtocol {
    @ObservedObject var viewModel: VM

    var body: some View {
        VStack {
            NavigationStack {
                ScrollView {
                    ForEach($viewModel.characters) { $character in
                        NavigationLink(destination:  CharacterDetailBuilder().build(with: character)) {
                            CharacterCellView(character: $character)
                                .padding(.trailing, 20)
                                .padding(.leading, 20)
                                .onChange(of: character, { oldValue, newValue in
                                    viewModel.addOrRemove(this: newValue)
                                })
                        }
                    }
                }.navigationTitle("Favorites")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }.task {
            await viewModel.load()
        }
    }
}
