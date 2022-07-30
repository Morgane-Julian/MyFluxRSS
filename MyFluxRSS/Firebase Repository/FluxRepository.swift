//
//  FluxRepository.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 28/04/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FluxRepository : ObservableObject {
    
    //MARK: - Properties
    
    private let path: String = "flux"
    private let store = Firestore.firestore()
    
   var fluxDatabase: [Flux] = []
    
    //MARK: - CRUD Functions
    
    func add(_ flux: Flux) {
        do {
            let newFlux = flux
            if let userID = AuthService.shared.user?.providerID {
                newFlux.userId = userID
            }
            _ = try store.collection(path).addDocument(from: newFlux)
            print("successfully add flux")
        } catch {
            fatalError("Unable to add flux: \(error.localizedDescription).")
        }
    }
    
    func get(callback: @escaping ([Flux]) -> Void) {
        store.collection(path)
            .whereField("userId", isEqualTo: AuthService.shared.user?.providerID as Any)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting flux: \(error.localizedDescription)")
                    return
                }
                callback(querySnapshot?.documents.compactMap { document in try? document.data(as: Flux.self) } ?? [])
            }
    }
    
    func remove(_ flux: Flux) {
        guard let fluxId = flux.id else { return }
        store.collection(path).document(fluxId).delete { error in
            if let error = error {
                print("Unable to remove article: \(error.localizedDescription).")
            }
        }
    }
}
