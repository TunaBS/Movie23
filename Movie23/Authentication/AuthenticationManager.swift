//
//  AuthenticationManager.swift
//  Movie23
//
//  Created by BS00880 on 24/6/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AuthenticationManager {
    public static let shared = AuthenticationManager()
    @Published var userFirebaseSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    private init() { }
    
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userFirebaseSession = result.user
            print("Sign In successful")
//            await fetchUser()
        } catch {
            print("Error while logging in \(error)")
        }
    }
    
    func createUser(userName: String, email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userFirebaseSession = result.user
            let user = User(id: result.user.uid, userName: userName, email: email, movies: [])
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            print("user created successfully")
//            await fetchUser()
        } catch {
            print("Error in creating user \(error)")
        }
    }
}
