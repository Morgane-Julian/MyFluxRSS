//
//  MyFluxRSSApp.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import SwiftUI

@main
struct MyFluxRSSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel.init())
        }
    }
}
