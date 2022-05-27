//
//  ParametersViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 17/03/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ParametersViewModel: ObservableObject {
    
    var model = Model()
    @Published var fluxRepository = FluxRepository()
    @Published var theme = ["dark", "light", "system"]
    @Published var myFlux = [Flux()]
    @Published var urlString = ""
    @Published var facebook = true
    @Published var reddit = false
    @Published var youtube = true
    @Published var twitter = true
    @Published var notifications = true
    @Published var previewOptions = ["Always", "When Unlocked", "Never"]
    var myNewFlux : Flux = Flux()
    
    func addNewFlux() {
        if self.urlString != "" && urlString != " " {
            if fluxRepository.fluxDatabase.contains(where: { $0.flux == urlString}) {
                print("Erreur mon ami tu as déjà ce flux dans ta liste !")
            } else {
                myNewFlux.flux = urlString
                fluxRepository.add(myNewFlux)
            }
        } else {
            print("Attention ceci n'est pas un flux valide ! ")
        }
    }
    
    func delete(at offsets: IndexSet) {
        let idsToDelete = offsets.map { self.fluxRepository.fluxDatabase[$0].id }
        _ = idsToDelete.compactMap { [weak self] id in
            self?.fluxRepository.remove(fluxRepository.fluxDatabase.first(where: {$0.id == id})!)
        }
    }
    
    func disconnect() {
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
    }
}


