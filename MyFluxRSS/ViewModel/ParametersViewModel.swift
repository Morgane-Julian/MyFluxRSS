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
    
    
    @Published var fluxRepository = FluxRepository()
    @Published var theme = ["dark", "light", "system"]
    @Published var myFlux = [Flux]()
    @Published var urlString = ""
    @Published var notifications = true
    @Published var previewOptions = ["Always", "When Unlocked", "Never"]
    
    var model = ArticleParser()
    let user = Auth.auth().currentUser
    var credential: AuthCredential?
    
    var password = ""
    var confirmPassword = ""
    var email = ""
    var actualPassword = ""
    
    var myNewFlux: Flux = Flux()
    
    //MARK: DB Functions
    
    //Add a new flux url in DB
    func addNewFlux() {
        if self.urlString != "" && urlString != " " {
            if FIRUser.shared.fluxDatabase.contains(where: { $0.flux == urlString}) {
                print("Oups, you already add this flux !")
            } else {
                myNewFlux.flux = urlString
                fluxRepository.add(myNewFlux)
            }
        } else {
            print("Error, this is not a valid flux ! ")
        }
    }
    
    //Get the flux url from DB
    func getFlux() {
        fluxRepository.get { flux in
            self.myFlux = flux
        }
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
    
    func reauthenticate(email: String, password: String, callback: @escaping (Bool) -> Void) {
        self.credential = EmailAuthProvider.credential(withEmail: email, password: password)
        if let credential = self.credential {
            user?.reauthenticate(with: credential) { authDataResult, error  in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("GG reauth done !")
                    callback(true)
                }
            }
        }
    }
    
    func disconnect(callback: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            callback(true)
        }
        catch { print("already logged out")
        }
    }
    
    func changePassword(password: String) {
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                print("wp password changed")
            }
        }
    }
    
    func deleteAcount() {
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                print("account deleted successfully")
            }
        }
    }
    
    //MARK: - Theme Functions
    
    func changeDarkMode(state: Bool) {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
}


