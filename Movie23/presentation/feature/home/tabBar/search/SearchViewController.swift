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
//    let filterView = FilterSearchView()
    
    struct Cells {
        static let movieCell = "MovieCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        setUpTableUI()
        bindViewModel()
//        setUpFilterButton()
//        filterView.applyFilters = { [weak self] selectedGenres, selectedSort, selectedOrder in
//            // Update the filters and fetch filtered data here
//            self?.updateFilters(selectedGenres: selectedGenres, selectedSort: selectedSort, selectedOrder: selectedOrder)
//        }
    }
    
    private func updateFilters(selectedGenres: Set<MovieGenre>, selectedSort: SortBy?, selectedOrder: OrderBy?) {
        // Apply filters and update UI accordingly
        // Example: Reload table view data based on filtered values
        print("Selected Genres: \(selectedGenres)")
        print("Selected Sort: \(selectedSort?.rawValue ?? "None")")
        print("Selected Order: \(selectedOrder?.rawValue ?? "None")")
        
        // You can trigger fetching of filtered data here
        // Example: self.fetchFilteredMovies(genres: selectedGenres, sortBy: selectedSort, orderBy: selectedOrder)
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
        
        // Adding filter button to the search bar
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "slider.vertical.3"), style: .plain, target: self, action: #selector(filterButtonTapped))
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc private func filterButtonTapped() {
        presentFilterSearchView()
    }
    
    private func presentFilterSearchView() {
        let filterSearchView = FilterSearchView()
        filterSearchView.applyFilters = { [weak self] selectedGenres, selectedSort, selectedOrder in
            // Handle the selected filters here
            self?.handleSelectedFilters(genres: selectedGenres, sort: selectedSort, order: selectedOrder)
            self?.dismiss(animated: true, completion: nil)
        }
        
        let filterSearchViewController = UIViewController()
        filterSearchViewController.view = filterSearchView
        filterSearchViewController.modalPresentationStyle = .formSheet
        present(filterSearchViewController, animated: true, completion: nil)
    }
    
    private func handleSelectedFilters(genres: Set<MovieGenre>, sort: SortBy?, order: OrderBy?) {
        // Store the selected filters
        self.selectedGenres = genres
        self.selectedSort = sort
        self.selectedOrder = order
        
        let sortType = selectedSort?.rawValue
        let orderType = selectedOrder?.rawValue
        
        // Update your search or filtering logic here
        print("Selected Genres: \(genres)")
        print("Selected Sort in VC: \(sortType))")
        print("Selected Order in VC: \(orderType)")
        
        // Perform the search or update the UI with the filtered data
//        performSearch()
    }
    
//    @objc private func showFilterSheet() {
//        let filterView = FilterSearchView()
//        filterView.translatesAutoresizingMaskIntoConstraints = false
//        let hostingController = UIViewController()
//        hostingController.view.addSubview(filterView)
//        
//        NSLayoutConstraint.activate([
//            filterView.topAnchor.constraint(equalTo: hostingController.view.topAnchor),
//            filterView.leadingAnchor.constraint(equalTo: hostingController.view.leadingAnchor),
//            filterView.trailingAnchor.constraint(equalTo: hostingController.view.trailingAnchor),
//            filterView.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor)
//        ])
//        
//        hostingController.modalPresentationStyle = .pageSheet
//        if let sheet = hostingController.sheetPresentationController {
//            sheet.detents = [.medium(), .large()]
//        }
//        present(hostingController, animated: true, completion: nil)
//    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("print searched value: ", searchController.searchBar.text ?? "")
//        bindViewModel()
        viewModel.searchQuery = searchController.searchBar.text ?? ""
        viewModel.sortBy = selectedSort?.rawValue ?? ""
        viewModel.orderBy = selectedOrder?.rawValue ?? ""
    }
    
//    private func setUpFilterButton() {
//        let filterButton = UIBarButtonItem(customView: filterImageRight)
//        filterImageRight.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(filterButtonTapped))
//        filterImageRight.addGestureRecognizer(tapGesture)
//        self.navigationItem.rightBarButtonItem = filterButton
//    }
    
//    @objc private func filterButtonTapped() {
//        let filterSheet = UIAlertController(title: "Sort and Filter", message: "Choose your filter", preferredStyle: .actionSheet)
//        
//        filterSheet.addAction(UIAlertAction(title: "Option 1", style: .default, handler: { action in
//            print("Option 1 selected")
//            // Handle option 1 selection
//        }))
//        
//        filterSheet.addAction(UIAlertAction(title: "Option 2", style: .default, handler: { action in
//            print("Option 2 selected")
//            // Handle option 2 selection
//        }))
//        
//        filterSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        
//        // For iPad compatibility
//        if let popoverController = filterSheet.popoverPresentationController {
//            popoverController.barButtonItem = self.navigationItem.rightBarButtonItem
//        }
//        
//        self.present(filterSheet, animated: true, completion: nil)
//    }
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
