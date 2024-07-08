//
//  FavouriteMoviesViewModel.swift
//  Movie23
//
//  Created by BS00880 on 8/7/24.
//

import Foundation

class FavouriteMoviesViewModel {
    var movieList: [MovieListItemModel] = [] {
        didSet {
            self.movieListUpdated?()
        }
    }


    var movieListUpdated: (() -> Void)?

    private var movieRepository: MovieRepository
//    private var navigationViewModel: NavigationViewModel
    
    init(
        movieRepository: MovieRepository//,
//        navigationViewModel: NavigationViewModel
    ) {
        self.movieRepository = movieRepository
//        self.navigationViewModel = navigationViewModel
        fetchMovieList()
    }
    
    private func fetchMovieList() {
        Task {
            do {
                movieList = try await movieRepository.getFavoriteMovies()
                print("Favourite Movie List: \(movieList)")
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func onRefresh() {
        fetchMovieList()
    }
    
    func onClickedMovieItem(movieId: Int) {
        print("Favourite Movie clicked: \(movieId)")
//        navigationViewModel.navigateTo(screen: .movieDetails(id: movieId))
    }
    
    func onDeleteMovieItem(indexSet: IndexSet) {
        Task {
            do {
                for index in indexSet {
                    try await movieRepository.removeFavoriteMovie(movie:movieList[index])
                    print("Removed Favourite Movie with id: \(movieList[index].id)")
                }
                fetchMovieList()
            } catch {
                print("Favourite movie removal Error: \(error)")
            }
        }
    }
}
