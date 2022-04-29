//
//  UserRepository.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 28/04/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class UserRepository: ObservableObject {
    
    //MARK: - Properties
    private let path: String = "users"
    private let store = Firestore.firestore()
    var userId = ""
    private let authService = AuthService()
    private var cancellables: Set<AnyCancellable> = []
    var users : [InternalUser] = []
    
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
                self?.get()
            }
            .store(in: &cancellables)
    }
    
    //MARK: - CRUD Functions
    
    func add(_ user: InternalUser) {
        do {
            let newUser = user
            newUser.userId = userId
            _ = try store.collection(path).addDocument(from: newUser)
            print("successfully add flux")
        } catch {
            fatalError("Unable to add flux: \(error.localizedDescription).")
        }
    }
    
    func get() {
        store.collection(path)
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting articles: \(error.localizedDescription)")
                    return
                }
                self.users = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: InternalUser.self)
                } ?? []
            }
    }
    
    func remove(_ user: InternalUser) {
        guard let userId = user.id else { return }
        store.collection(path).document(userId).delete { error in
            if let error = error {
                print("Unable to remove article: \(error.localizedDescription).")
            }
        }
    }
    
}
