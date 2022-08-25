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
    
    //MARK: - Properties
    
    @Published var theme = ["dark", "light", "system"]
    @Published var myFlux = [Flux]()
    @Published var urlString = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var email = ""
    @Published var actualPassword = ""
    var myNewFlux: Flux = Flux()
    let fluxRepository: FluxRepository
    let authService: AuthService
    
    //MARK: - Init
    init(fluxRepository: FluxRepository = FluxRepository(repository: RepositoryFirebase(path: "flux")), authService: AuthService = AuthService(auth: AuthFirebase())) {
        self.fluxRepository = fluxRepository
        self.authService = authService
    }
    
    //MARK: DB Functions
    
    //Add a new flux url in DB
    func addNewFlux(userID: String) {
        if self.urlString != "" && urlString != " " {
            self.getFlux(userID: userID)
            if self.myFlux.contains(where: { $0.flux == urlString}) {
                print("Oups, you already add this flux !")
            } else {
                myNewFlux.flux = urlString
                self.fluxRepository.add(myNewFlux, callback: { success in
                    if success {
                        self.myFlux.append(self.myNewFlux)
                    }
                })
            }
        } else {
            print("Error, this is not a valid flux !")
        }
    }
    
    //Get the flux url from DB
    func getFlux(userID: String) {
        self.fluxRepository.get(userId: userID, callback: { flux in
            self.myFlux = flux
        })
    }
    
    //Delete a flux url in DB
    func delete(at offsets: IndexSet) {
        let idToDelete = offsets.map { self.myFlux[$0].id }
        _ = idToDelete.compactMap { [weak self] id in
            self?.fluxRepository.remove(myFlux.first(where: {$0.id == id})!)
            guard let intID = Int(id!) else { return }
            self?.myFlux.remove(at: intID)
        }
    }
    
    //MARK: Manage account functions
    
    //Reauthenticate user for token before account changes
    func reauthenticate(email: String, password: String, callback: @escaping (Bool) -> Void) {
        self.authService.reauthenticate(email: email, password: password, callback: { success in
            if success {
                print("Password changed")
            } else {
                print("Password error, try again")
            }
            callback(success)
        })
    }
    
    //Disconnect actual user
    func disconnect(callback: @escaping (Bool) -> Void) {
        self.authService.disconnect(callback: { success in
            if success {
                print("Disconnected")
            } else {
                print("Disconnect failed")
            }
            callback(success)
        })
    }
    
    //Change the password for the current user
    func changePassword(password: String, callback: @escaping (Bool) -> Void) {
        self.authService.changePassword(password: password, callback: { success in
                callback(success)
        })
    }
    
    //Delete account for current user
    func deleteAcount(callback: @escaping (Bool) -> Void) {
        self.authService.deleteAcount(callback: { success in
            callback(success)
        })
    }
    
    
    //MARK: - Theme Functions
    
    //Override system theme information to pass dark mode in app
    func changeDarkMode(state: Bool) {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
}


