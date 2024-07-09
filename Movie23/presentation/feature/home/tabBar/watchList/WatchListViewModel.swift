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
@MainActor
class WatchListViewModel: ObservableObject {
//    let currentUser = AuthenticationManager.shared.currentUser
    public static let shared = WatchListViewModel()
    @Published var currentUser: User?
    private var userId: String?
    @Published var itemAlreadyInWatchList: Bool = false
    
    @Published var movieArray: [MovieListItemModel] = [] {
        didSet {
            print("movie array didset called")
//            self.movieListUpdated?()
            self.notifyMovieListUpdated()
            Task {
                await saveItems()
            }
        }
    }
    var movieListUpdated: (() -> Void)?
    
    init() {
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
            Task {
                await fetchUser()
            }
        }
    }
    
    func fetchUser() async {
        guard let uid = userId else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        print("From watchlist view model Fetched current user \(self.currentUser)")
        print("From watchlist view model current user name \(self.currentUser?.userName)")
        print("cFrom watchlist view modelcurrent user email id \(self.currentUser?.email)")
        self.movieArray = currentUser?.movies ?? []
        self.notifyMovieListUpdated()
    }

    func deleteItems(indexSet: IndexSet) {
        movieArray.remove(atOffsets: indexSet)
        Task {
            await saveItems()
        }
    }
    
    func deleteItems(movie: MovieListItemModel) {
        let id = movie.id
        movieArray.removeAll(where: { $0.id == id})
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
            movieArray.append(movie/*addToFavourites(movie: movie)*/)
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
    
    func addToFavourites(movie: MovieListItemModel) -> MovieListItemModel {
        var favouriteMovie = movie
        favouriteMovie.isFavourite = true
        return favouriteMovie
    }
    
    func removeFromFavourites(movie: MovieListItemModel) -> MovieListItemModel {
        var notFavouriteMovie = movie
        notFavouriteMovie.isFavourite = false
        return notFavouriteMovie
    }
    
    func notifyMovieListUpdated() {
        print("movieListUpdated closure called")
        self.movieListUpdated?()
    }
}
