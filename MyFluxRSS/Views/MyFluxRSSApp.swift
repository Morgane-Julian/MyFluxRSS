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
    
    let appState = AppState()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView(contentViewModel: AuthViewModel.init())
                .environmentObject(appState)
        }
    }
}
