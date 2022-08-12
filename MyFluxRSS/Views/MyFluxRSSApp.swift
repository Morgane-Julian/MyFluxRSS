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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            AuthView(contentViewModel: AuthViewModel.init())
                .environmentObject(appState)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        AuthService.shared.auth.isUserConnected()
        
        return true
    }
}
