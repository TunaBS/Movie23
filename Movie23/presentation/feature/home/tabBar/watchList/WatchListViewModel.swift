//
//  WatchListViewModel.swift
//  Movie23
//
//  Created by BS00880 on 9/7/24.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class WatchListViewModel: ObservableObject {
    let currentUser = AuthenticationManager.shared.currentUser
    public static let shared = WatchListViewModel()
    
    private var userId: String?
    @Published var itemAlreadyInWatchList: Bool = false
    
    @Published var movieArray: [MovieListItemModel] = [] {
        didSet {
            Task {
                await saveItems()
            }
        }
    }
    
    init() {
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
            Task {
                await fetchUser()
            }
        }
    }
    
    func fetchUser() async {
        print("From watchlist view model Fetched current user \(self.currentUser)")
        print("From watchlist view model current user name \(self.currentUser?.userName)")
        print("cFrom watchlist view modelcurrent user email id \(self.currentUser?.email)")
        self.movieArray = currentUser?.movies ?? []
    }

    func deleteItems(indexSet: IndexSet) {
        movieArray.remove(atOffsets: indexSet)
        Task {
            await saveItems()
        }
    }
    
    func moveItems(from: IndexSet, to: Int) {
        movieArray.move(fromOffsets: from, toOffset: to)
    }
    
    func addItems(movie: MovieListItemModel) {
        if movieArray.contains(where: { $0.id == movie.id }) {
            itemAlreadyInWatchList = true
        }
        else {
            itemAlreadyInWatchList = false
            movieArray.append(movie)
        }
        Task {
            await saveItems()
        }
    }
    
    func saveItems() async {
        await updateInFirestore()
    }
    
    func updateInFirestore () async /*throws */{
        guard let uid = currentUser?.id else { return }
        guard var currentUserInfo = currentUser else { return }
        currentUserInfo.movies = movieArray
        let personInfo = Firestore.firestore().collection("users").document(uid)
        do {
            try await personInfo.setData(from: currentUserInfo)
            print("Document successfully updated")
        } catch {
            print("Error updating document: \(error)")
        }
    }
}
