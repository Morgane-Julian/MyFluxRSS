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

    //MARK: - Properties
    
    var path: String
    var store = Firestore.firestore()
    
    //MARK: Init
    
    init(path: String) {
        self.path = path
    }
    
    //MARK: - Functions
    
    //Add a document in DB
    func addDocument<T: Codable>(document: T, userID: String, callback: @escaping (Bool) -> Void) {
        do {
            try _ = store.collection(self.path).addDocument(from: document)
        } catch {
            fatalError("Unable to add \(self.path): \(error.localizedDescription).")
        }
    }
    
    //Get documents from DB
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
    
    //Delete a document in DB
    func deleteDocument(documentID: String, callback: @escaping (Bool) -> Void) {
        store.collection(self.path).document(documentID).delete { error in
            if let error = error {
                print("Unable to remove article: \(error.localizedDescription).")
            }
        }
    }
}
