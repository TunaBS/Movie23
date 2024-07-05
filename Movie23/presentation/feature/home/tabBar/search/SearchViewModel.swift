//
//  SearchViewModel.swift
//  Movie23
//
//  Created by BS00880 on 4/7/24.
//

import Foundation

class SearchViewModel {
    
    private var hasSearchQueryChanged = false
    private var hasSortByChanged = false
    private var hasOrderByChanged = false
    
    var movieList: [MovieListItemModel] = [] {
        didSet {
            self.movieListUpdated?()
        }
    }
    
    var movieListUpdated: (() -> Void)?
    
    private var movieRepository: MovieRepository
//    private var navigationViewModel: NavigationViewModel
    
    init(movieRepository: MovieRepository/*, navigationViewModel: NavigationViewModel*/) {
        self.movieRepository = movieRepository
//        self.navigationViewModel = navigationViewModel
        fetchMovieListUsingQuery()
    }
    
    var searchQuery: String = "" {
        didSet {
            print("Search query changed: \(searchQuery)")
            hasSearchQueryChanged = true
            checkAndDebounceSearch()
//            debouncedSearch()
        }
    }
    
    var sortBy: String = "" {
        didSet {
            print("Sort By order now: \(sortBy)")
            hasSortByChanged = true
            checkAndDebounceSearch()
//            debouncedSearch()
        }
    }
    
    var orderBy: String = "" {
        didSet {
            print("Order By now: \(orderBy)")
            hasOrderByChanged = true
            checkAndDebounceSearch()
//            debouncedSearch()
        }
    }
    
    func onSearchSubmit() {
        print("Search query submitted: \(searchQuery)")
    }
    
    private func checkAndDebounceSearch() {
        if hasSearchQueryChanged || hasSortByChanged || hasOrderByChanged {
//            hasSearchQueryChanged = true
//            hasSortByChanged = true
//            hasOrderByChanged = true
            debouncedSearch()
        } else {
//            debouncedSearch()
            print("Nothing updated")
        }
        refreshValues()
//        onRefresh()
    }
    
    private func debouncedSearch() {
        Debouncer.shared.debounce {
            self.fetchMovieListUsingQuery()
        }
    }
    
    private func fetchMovieListUsingQuery() {
        print("Fetching movie list using query: \(searchQuery) and \(sortBy) and \(orderBy)")
        Task {
            do {
                if searchQuery == "" {
                    movieList = []
                } else {
                    movieList = try await movieRepository.getMovieListByQuery(query: searchQuery, sortBy: sortBy, orderBy: orderBy)
                }
//                print("Movie List: \(movieList)")
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func refreshValues() {
        hasSearchQueryChanged = false
        hasSortByChanged = false
        hasOrderByChanged = false
    }
    
    func onRefresh() {
        fetchMovieListUsingQuery()
    }
    
//    func onClickedMovieItem(movieId: Int) {
//        print("Movie clicked: \(movieId)")
////        navigationViewModel.navigateTo(screen: .movieDetails(id: movieId))
//    }
    
//    func toggleFavourite(movie: MovieListItemModel) {
//        Task {
//            do {
//                if(movie.isFavourite) {
//                    try await movieRepository.removeFavoriteMovie(movie: movie)
//                    print("Removed from favourite: \(movie)")
//                } else {
//                    try await movieRepository.addFavoriteMovie(movie: movie)
//                    print("Added to favourite: \(movie)")
//                }
//                fetchMovieListUsingQuery()
//            } catch {
//                print("Favourite toggle Error: \(error)")
//            }
//        }
//    }
}
