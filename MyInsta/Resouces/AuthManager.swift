//
//  AuthManager.swift
//  MyInsta
//
//  Created by Nam on 12/15/20.
//

import Foundation
import Firebase

class AuthManager {
    static let shared = AuthManager()
    let db = Firestore.firestore()
    // MARK: -Public
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        //login voi email
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        
        //login voi username
//        if let username = username {
//            Auth.au
//        }
        
    }
    
    public func registerUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result,error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            
        }
//        let user = User(username: username, email: email)
//        db.collection("users").addDocument(data: user.dictionary)
        
        db.collection("users").addDocument(data: ["username" : username, "email" : email])
    }
    
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            print(error)
            completion(false)
            return
        }
    }
}

