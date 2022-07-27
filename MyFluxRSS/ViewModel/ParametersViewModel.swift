//
//  ParametersViewModel.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 17/03/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

class ParametersViewModel: ObservableObject {
    
    var model = Model()
    @Published var fluxRepository = FluxRepository()
    @Published var theme = ["dark", "light", "system"]
    @Published var myFlux = [Flux()]
    @Published var urlString = ""
    @Published var notifications = true
    @Published var previewOptions = ["Always", "When Unlocked", "Never"]
    
    var myNewFlux : Flux = Flux()
    
    //MARK: DB Functions
    
    func addNewFlux() {
        if self.urlString != "" && urlString != " " {
            if fluxRepository.fluxDatabase.contains(where: { $0.flux == urlString}) {
                print("Oups, you already add this flux !")
            } else {
                myNewFlux.flux = urlString
                fluxRepository.add(myNewFlux)
            }
        } else {
            print("Error, this is not a valid flux ! ")
        }
    }
    
    func getFlux() {
        fluxRepository.get { flux in
            self.myFlux = flux
        }
    }
    
    func delete(at offsets: IndexSet) {
        let idToDelete = offsets.map { self.myFlux[$0].id }
        _ = idToDelete.compactMap { [weak self] id in
            self?.fluxRepository.remove(myFlux.first(where: {$0.id == id})!)
            guard let intID = Int(id!) else { return }
            self?.myFlux.remove(at: intID)
        }
    }
    
    func disconnect() {
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
    }
    
    
    //MARK: - Theme Functions
    func changeDarkMode(state: Bool) {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
    
   
    
}


