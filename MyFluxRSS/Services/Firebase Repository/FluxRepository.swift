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
    private let repository: Repository
    
    //MARK: - Init
    init(repository: Repository = RepositoryFirebase(path: "flux")) {
        self.repository = repository
    }
    
    //MARK: - CRUD Functions
    
    // Add a flux in DB
    func add(_ flux: Flux, callback: @escaping (Bool) -> Void) {
        let newFlux = flux
        newFlux.userId = InternalUser.shared.userID
        self.repository.addDocument(document: flux, userID: InternalUser.shared.userID, callback: { success in
            callback(success)
        })
    }
    
    // Get the flux list in DB
    func get(userId: String, callback: @escaping ([Flux]) -> Void) {
        self.repository.getDocument(userID: userId, callback: callback)
    }
    
    // Remove a flux in DB
    func remove(_ flux: Flux) {
        guard let fluxId = flux.id else { return }
        self.repository.deleteDocument(documentID: fluxId , callback: { success in
            if success {
                print("successfully remove flux")
            } else {
                print("Flux can't be delete")
            }
        })
    }
}
