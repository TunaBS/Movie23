////
////  DatabaseServiceImp.swift
////  Movie23
////
////  Created by BS00880 on 9/7/24.
////
//
//import Foundation
//
//
//@available(iOS 17, *)
//class DatabaseServiceImp: DatabaseService {
//    
//    var favouriteMoviesLocalClient: FavouriteMoviesDatabaseClient
//    
//    @MainActor
//    init(favouriteMoviesLocalClient: FavouriteMoviesDatabaseClient = FavouriteMoviesDatabaseClient.shared) {
//        self.favouriteMoviesLocalClient = favouriteMoviesLocalClient
//    }
//    
//    func getFavouriteMovieList() async throws -> [FavouriteMovieDatabaseModel] {
//        return favouriteMoviesLocalClient.fetchItems()
//    }
//    
//    func addFavouriteMovie(movie: FavouriteMovieDatabaseModel) async throws {
//        let movies = try await getFavouriteMovieList()
//        if(movies.contains{ $0.id == movie.id }) {
//            print("Movie already exists in favourite list")
//            return
//        }
//        favouriteMoviesLocalClient.appendItem(item: movie)
//    }
//    
//    func removeFavouriteMovie(movieId: Int) async throws {
//        let movies = try await getFavouriteMovieList()
//        movies.filter{ $0.id == movieId }.forEach{
//            favouriteMoviesLocalClient.removeItem($0)
//        }
//    }
//    
//}
