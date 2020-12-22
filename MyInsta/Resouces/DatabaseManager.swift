//
//  DatabaseManager.swift
//  MyInsta
//
//  Created by Nam on 12/15/20.
//

//import Foundation
//import FirebaseFirestore
//
//class DatabaseManager {
//    static let shared = DatabaseManager()
//    
//    let db = Firestore.firestore()
//    
//    public func insertNewUser(username: String, email: String, completion: @escaping (Bool) -> Void) {
//        db.collection("users").addDocument(data: ["username" : username, "email" : email]) { success in
//            if success {
//                completion(true)
//            }
//        }
//    }
//}
