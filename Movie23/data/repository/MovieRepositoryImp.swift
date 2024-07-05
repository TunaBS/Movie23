//
//  MovieRepositoryImp.swift
//  Movie23
//
//  Created by BS00880 on 1/7/24.
//

import Foundation

class MovieRepositoryImpl: MovieRepository {
    
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getMovieList() async throws -> [MovieListItemModel] {
        let response: BaseResponse<MovieListResponse> = try await apiService.getMovieList()
//        let favouriteMovieIds = try await getFavouriteMovieIds()
        return response.data.movies.map{ movie in
            MovieListItemModel.fromMovie(
                movie: movie//,
//                isFavourite: favouriteMovieIds.contains(movie.id)
            )
        }
    }
    
    func getMovieListByQuery(query: String, sortBy: String? = nil, orderBy: String? = nil) async throws -> [MovieListItemModel] {
        let response = try await apiService.getMovieListByQuery(query: query, sortBy: sortBy, orderBy: orderBy)
//        let favouriteMovieIds = try await getFavouriteMovieIds()
        return response.data.movies.map{ movie in
            MovieListItemModel.fromMovie(
                movie: movie//,
//                isFavourite: favouriteMovieIds.contains(movie.id)
            )
        }
    }
    
    func getMovieDetails(movieId: Int) async throws -> MovieDetailsModel {
        let response = try await apiService.getMovieDetails(movieId: movieId)
        
//        let favouriteMovieIds = try await getFavouriteMovieIds()
        return MovieDetailsModel.fromMovie(
            movie: response.data.movie
        )
    }
    
    func getMovieListByGenre(genre: MovieGenre) async throws -> [MovieListItemModel] {
            let response = try await apiService.getMovieListByGenre(genre: genre)
            
//            let favouriteMovieIds = try await getFavouriteMovieIds()
            return response.data.movies.map{ movie in
                MovieListItemModel.fromMovie(
                    movie: movie//,
//                    isFavourite: favouriteMovieIds.contains(movie.id)
                )
            }
        }
}
