//
//  MovieListViewController.swift
//  Movie23
//
//  Created by BS00880 on 26/6/24.
//

import UIKit

class MovieListViewController: UIViewController {
    
    var tableView = UITableView()
    var movies: [Movie] = []
    
    struct Cells {
        static let movieCell = "MovieCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
    func fetchMovieList() -> [Movie] {
        return Movie.movieArrayShowForTest
    }
}
