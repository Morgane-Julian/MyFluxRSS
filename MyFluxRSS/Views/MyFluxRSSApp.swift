//
//  MyFluxRSSApp.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 06/03/2022.
//

import SwiftUI
import Firebase

@main
struct MyFluxRSSApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(contentViewModel: ContentViewModel.init())
        }
    }
}
