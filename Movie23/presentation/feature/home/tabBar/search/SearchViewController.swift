//
//  SearchController.swift
//  Movie23
//
//  Created by BS00880 on 3/7/24.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    let viewModel = SearchViewModel(movieRepository: MovieRepositoryImpl(apiService: APIServiceImplemention(apiClient: APIClientImp())))
    private let searchController = UISearchController(searchResultsController: nil)
    var tableView = UITableView()
    var movies: [MovieListItemModel] = []

    let filterImageRight = UIImageView(image: UIImage(systemName: "slider.vertical.3"))
    
    struct Cells {
        static let movieCell = "MovieCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        setUpTableUI()
        bindViewModel()
        setUpFilterButton()
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
        viewModel.movieListUpdated = { [weak self] in
            self?.loadMovies()
        }
    }
    
    private func loadMovies() {
        DispatchQueue.main.async {
            self.movies = self.viewModel.movieList
            self.tableView.reloadData()
        }
    }
    
    
    private func setUpSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Movies"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("print searched value: ", searchController.searchBar.text ?? "")
//        bindViewModel()
        viewModel.searchQuery = searchController.searchBar.text ?? ""
    }
    
    private func setUpFilterButton() {
        let filterButton = UIBarButtonItem(customView: filterImageRight)
        filterImageRight.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(filterButtonTapped))
        filterImageRight.addGestureRecognizer(tapGesture)
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc private func filterButtonTapped() {
        let filterSheet = UIAlertController(title: "Filter Options", message: "Choose your filter", preferredStyle: .actionSheet)
        
        filterSheet.addAction(UIAlertAction(title: "Option 1", style: .default, handler: { action in
            print("Option 1 selected")
            // Handle option 1 selection
        }))
        
        filterSheet.addAction(UIAlertAction(title: "Option 2", style: .default, handler: { action in
            print("Option 2 selected")
            // Handle option 2 selection
        }))
        
        filterSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // For iPad compatibility
        if let popoverController = filterSheet.popoverPresentationController {
            popoverController.barButtonItem = self.navigationItem.rightBarButtonItem
        }
        
        self.present(filterSheet, animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(viewModel.movieList.count)
//        return viewModel.movieList.count
        print("Found \(movies.count)")
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movieCell) as! MovieListTableViewCell
        let singleMovie = movies[indexPath.row]
        cell.setCellValue(movie: singleMovie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movieList[indexPath.row]
        
        // Instantiate the detail view controller
        let detailViewController = MovieDetailsViewController()
        
        // Pass the selected movie to the detail view controller
//        detailViewController.movie = selectedMovie
        detailViewController.movieId = selectedMovie.id
        
        // Navigate to the detail view controller
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
