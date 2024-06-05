//
//  ContentView.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false

    var body: some View {
        if self.isActive {
            TabBarView()
        } else {
            VStack {
                Image("RickAndMortySplash")
                    .resizable()
                    .scaledToFill()
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}
