//
//  RickAndMortySwiftUIApp.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import SwiftUI

@main
struct RickAndMortySwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.environment["isUnitTesting"] == "0" {
                SplashView()
            }
        }
    }
}
