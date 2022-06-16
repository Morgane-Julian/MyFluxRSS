//
//  FluxRepository.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 28/04/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine


class FluxRepository : ObservableObject {
    
    //MARK: - Properties
    
    private let path: String = "flux"
    private let store = Firestore.firestore()
    
    var userId = ""
    private let authService = AuthService()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var fluxDatabase: [Flux] = []
    
    //MARK: - Init
    
    init() {
        authService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)
        
        authService.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.get { _ in }
            }
            .store(in: &cancellables)
    }
    
    //MARK: - CRUD Functions
    
    func add(_ flux: Flux) {
        do {
            let newFlux = flux
            newFlux.userId = userId
            _ = try store.collection(path).addDocument(from: newFlux)
            print("successfully add flux")
        } catch {
            fatalError("Unable to add flux: \(error.localizedDescription).")
        }
    }
    
    func get(callback: @escaping ([Flux]) -> Void) {
        store.collection(path)
            .whereField("userId", isEqualTo: userId)
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
