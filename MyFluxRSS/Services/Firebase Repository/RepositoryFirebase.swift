//
//  RepositoryFirebase.swift
//  MyFluxRSS
//
//  Created by Morgane Julian on 12/08/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol Repository {
    func addDocument<T: Codable>(document: T, userID: String, callback: @escaping (Bool) -> Void)
    func getDocument<T: Codable>(userID: String, callback: @escaping ([T]) -> Void)
    func deleteDocument(documentID: String, callback: @escaping (Bool) -> Void)
}

class RepositoryFirebase: Repository {

    var path: String
    
    init(path: String) {
        self.path = path
    }
    
    var store = Firestore.firestore()
    
    func addDocument<T: Codable>(document: T, userID: String, callback: @escaping (Bool) -> Void) {
        do {
            try _ = store.collection(self.path).addDocument(from: document)
        } catch {
            fatalError("Unable to add \(self.path): \(error.localizedDescription).")
        }
    }
    
    func getDocument<T: Codable>(userID: String, callback: @escaping ([T]) -> Void) {
        store.collection(self.path)
            .whereField("userId", isEqualTo: userID)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting \(self.path): \(error.localizedDescription)")
                    return
                }
                callback(querySnapshot?.documents.compactMap { document in try? document.data(as: T.self) } ?? [])
            }
    }
    
    func deleteDocument(documentID: String, callback: @escaping (Bool) -> Void) {
        store.collection(self.path).document(documentID).delete { error in
            if let error = error {
                print("Unable to remove article: \(error.localizedDescription).")
            }
        }
    }
}
