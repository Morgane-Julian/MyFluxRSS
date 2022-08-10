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
    
    //Create a singleton instance of flux repository
    static let shared: FluxRepository = {
        let instance = FluxRepository()
        return instance
    }()
    
    //MARK: - Properties
    
    private let path: String = "flux"
    private let store = Firestore.firestore()
    
    
    //MARK: - CRUD Functions
    
    // Add a flux in DB
    func add(_ flux: Flux, callback: @escaping (Bool) -> Void) {
        var success = false
        do {
            let newFlux = flux
            newFlux.userId = InternalUser.shared.userID
            _ = try store.collection(path).addDocument(from: newFlux)
            print("successfully add flux")
            success = true
        } catch {
            fatalError("Unable to add flux: \(error.localizedDescription).")
        }
        callback(success)
    }
    
    // Get the flux list in DB
    func get(callback: @escaping ([Flux]) -> Void) {
        store.collection(path)
            .whereField("userId", isEqualTo: InternalUser.shared.userID)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting flux: \(error.localizedDescription)")
                    return
                }
                callback(querySnapshot?.documents.compactMap { document in try? document.data(as: Flux.self) } ?? [])
            }
    }
    
    // Remove a flux in DB
    func remove(_ flux: Flux) {
        guard let fluxId = flux.id else { return }
        store.collection(path).document(fluxId).delete { error in
            if let error = error {
                print("Unable to remove article: \(error.localizedDescription).")
            }
        }
    }
}
