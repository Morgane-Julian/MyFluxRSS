//
//  ParametersViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 17/03/2022.
//

import Foundation
import Firebase

class ParametersViewModel: ObservableObject {
    
    var model = Model()
    
    @Published var theme = ["dark", "light", "system"]
    @Published var myFlux = [Flux()]
    @Published var urlString = ""
    @Published var facebook = true
    @Published var reddit = false
    @Published var youtube = true
    @Published var twitter = true
    @Published var notifications = true
    @Published var previewOptions = ["Always", "When Unlocked", "Never"]
    
    func addNewFlux() {
        let myNewFlux : Flux = Flux()
        myNewFlux.flux = urlString
        self.myFlux.append(myNewFlux)
        model.getArticles()
    }
    func disconnect() {
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
    }
}

class Flux: Identifiable {
    var flux = "unfluxdequalité"
}
