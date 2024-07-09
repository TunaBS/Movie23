//
//  WatchListViewController.swift
//  Movie23
//
//  Created by BS00880 on 8/7/24.
//

import UIKit

class WatchListViewController: UIViewController {
    
    let viewModel = WatchListViewModel.shared
//    let currentUserMovies = AuthenticationManager.shared.currentUser?.movies
    
    var tableView = UITableView()
    var movies: [MovieListItemModel] = []
    
    struct Cells {
        static let movieCell = "MovieCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
//        title = "Watch List"
        self.setUpTableUI()
        bindViewModel()
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
    
    private func bindViewModel() {
        loadMovies()
    }
    
    private func loadMovies() {
        movies = viewModel.movieArray
        tableView.reloadData()
    }
    
}

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.movieArray.count)
        return viewModel.movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movieCell) as! MovieListTableViewCell
        let singleMovie = movies[indexPath.row]
        cell.setCellValue(movie: singleMovie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movieArray[indexPath.row]
        
        // Instantiate the detail view controller
        let detailViewController = MovieDetailsViewController()
        
        // Pass the selected movie to the detail view controller
//        detailViewController.movie = selectedMovie
        detailViewController.movieId = selectedMovie.id
        
        // Navigate to the detail view controller
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

