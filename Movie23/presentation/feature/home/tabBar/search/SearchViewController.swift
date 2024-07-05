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

    private var selectedGenres: Set<MovieGenre> = []
    private var selectedSort: SortBy? = nil
    private var selectedOrder: OrderBy? = nil
    let filterImageRight = UIImageView(image: UIImage(systemName: "slider.vertical.3"))
    
    struct Cells {
        static let movieCell = "MovieCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        setUpTableUI()
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
        
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "slider.vertical.3"), style: .plain, target: self, action: #selector(filterButtonTapped))
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc private func filterButtonTapped() {
        presentFilterSearchView()
    }
    
    private func presentFilterSearchView() {
        let filterSearchView = FilterSearchView()
        filterSearchView.applyFilters = { [weak self] selectedGenres, selectedSort, selectedOrder in
            self?.handleSelectedFilters(genres: selectedGenres, sort: selectedSort, order: selectedOrder)
            self?.dismiss(animated: true, completion: nil)
        }
        
        let filterSearchViewController = UIViewController()
        filterSearchViewController.view = filterSearchView
        filterSearchViewController.modalPresentationStyle = .formSheet
        present(filterSearchViewController, animated: true, completion: nil)
    }
    
    private func handleSelectedFilters(genres: Set<MovieGenre>, sort: SortBy?, order: OrderBy?) {
        self.selectedGenres = genres
        self.selectedSort = sort
        self.selectedOrder = order
        
        let sortType = selectedSort?.rawValue
        let orderType = selectedOrder?.rawValue
        
        print("Selected Genres: \(genres)")
        print("Selected Sort in VC: \(sortType))")
        print("Selected Order in VC: \(orderType)")
        
        viewModel.sortBy = selectedSort?.rawValue ?? ""
        viewModel.orderBy = selectedOrder?.rawValue ?? ""

    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("print searched value: ", searchController.searchBar.text ?? "")
        viewModel.searchQuery = searchController.searchBar.text ?? ""
        viewModel.sortBy = selectedSort?.rawValue ?? ""
        viewModel.orderBy = selectedOrder?.rawValue ?? ""
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        let detailViewController = MovieDetailsViewController()
        detailViewController.movieId = selectedMovie.id
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
