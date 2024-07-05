//
//  MovieRepository.swift
//  Movie23
//
//  Created by BS00880 on 1/7/24.
//

import Foundation

protocol MovieRepository {
    func getMovieList() async throws -> [MovieListItemModel]
    func getMovieListByQuery(query: String, sortBy: String?, orderBy: String?) async throws -> [MovieListItemModel]
    func getMovieListByGenre(genre: MovieGenre) async throws -> [MovieListItemModel]
    func getMovieDetails(movieId: Int) async throws-> MovieDetailsModel
    
//    func getFavoriteMovies() async throws -> [MovieListItemModel]
//    func addFavoriteMovie(movie: MovieListItemModel) async throws -> Void
//    func removeFavoriteMovie(movie: MovieListItemModel) async throws -> Void
}
