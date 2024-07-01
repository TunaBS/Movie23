//
//  DatabaseService.swift
//  Movie23
//
//  Created by BS00880 on 1/7/24.
//

import Foundation


protocol DatabaseService {
    func getFavouriteMovieList() async throws -> [FavouriteMovieDatabaseModel]
    func addFavouriteMovie(movie: FavouriteMovieDatabaseModel) async throws
    func removeFavouriteMovie(movieId: Int) async throws
}
