//
//  MovieListViewController.swift
//  Movie23
//
//  Created by BS00880 on 26/6/24.
//

import UIKit

class MovieListViewController: UIViewController {
    
    var tableView = UITableView()
    var movies: [MovieDetailsResponse.Movie] = []
    var viewModel: MovieListViewModel?
    
    struct Cells {
        static let movieCell = "MovieCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            viewModel = MovieListViewModel(
                movieRepository: try DiContainer.shared.resolve(type: MovieRepository.self)
                // navigationViewModel: NavigationViewModel.shared
            )
        } catch {
            print("Failed to initialize MovieListViewModel: \(error)")
        }
        
        title = "Movie Lists"
        movies = fetchMovieList()
        setUpTableUI()
    }
    
    func setUpTableUI() {
        view.addSubview(tableView)
        setDelegate()
        tableView.rowHeight = 150
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: Cells.movieCell)
        tableView.pin(to: view)
        
    }
    
    func setDelegate () {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
//    private func bindViewModel() {
//        // Observe changes in the view model and update the UI accordingly
//        guard let viewModel = viewModel else {
//            print("viewModel is nil")
//            return
//        }
//        
//        // Observe changes in the view model and update the UI accordingly
//        viewModel.movieListUpdated = { [weak self] movies in
//            // Update your UI with the new movies
//            print("entered into poster view")
//        }
//    }
    
    
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movies.count)
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movieCell) as! MovieListTableViewCell
        let singleMovie = movies[indexPath.row]
        cell.setCellValue(movie: singleMovie)
        return cell
    }
    
    
}

extension MovieListViewController {
    func fetchMovieList() -> [MovieDetailsResponse.Movie] {
        return MovieDetailsResponse.Movie.movieArrayShowForTest
    }
}
