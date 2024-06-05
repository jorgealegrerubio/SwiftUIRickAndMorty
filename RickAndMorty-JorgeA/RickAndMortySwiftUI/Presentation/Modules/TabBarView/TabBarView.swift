//
//  TabBarView.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            CharactersListBuilder().build()
                .tabItem {
                    Label("Characters", image: "ic_ricky")
                }

            EpisodesListBuilder().build()
                .tabItem {
                    Label("Episodes", image: "clapperboard")
                }
            FavoritesBuilder().build()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
        .tint(.green)
        .background(.gray)
    }
}
