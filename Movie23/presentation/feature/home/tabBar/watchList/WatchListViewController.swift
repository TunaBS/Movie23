//
//  WatchListViewController.swift
//  Movie23
//
//  Created by BS00880 on 3/7/24.
//

import UIKit

class WatchListViewController: UIViewController {

    let viewModel = MovieListViewModel(movieRepository: MovieRepositoryImpl(apiService: APIServiceImplemention(apiClient: APIClientImp())))
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
//        scrollView.backgroundColor = .blue         //use color for testing
        scrollView.isPagingEnabled = true
        return scrollView
    } ()
    
    private let stackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
//        stackView.backgroundColor = .red          //use color for testing
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    } ()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        bindViewModel()
        self.setUpUI()
    }
    
    private func setUpUI() {
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            
            pageControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        scrollView.addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackview.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackview.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.movieListUpdated = { [weak self] in
            self?.addBannerViews()
        }
    }
    
    private func addBannerViews(/*with movieList: [MovieListItemModel]*/) {
        
        for (index, movie) in viewModel.movieList.enumerated() {
            let bannerView = movieBannerView(movie: movie)
            stackview.addArrangedSubview(bannerView)
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            bannerView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            
//            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bannerViewTapped(_:)))
//            bannerView.isUserInteractionEnabled = true
//            bannerView.addGestureRecognizer(tapGestureRecognizer)
//            bannerView.tag = movie.id
            
            bannerView.tag = index
        }
        pageControl.numberOfPages = viewModel.movieList.count
        pageControl.currentPage = 0
        
        scrollView.delegate = self
        view.layoutIfNeeded() // Ensure the layout is updated
    }
    
    @objc private func bannerViewTapped(_ sender: UITapGestureRecognizer) {
        if let bannerView = sender.view {
            let movieId = bannerView.tag
            navigateToMovieDetails(movieId: movieId)
        }
    }

    private func navigateToMovieDetails(movieId: Int) {
        let movieDetailsViewController = MovieDetailsViewController()
        movieDetailsViewController.movieId = movieId
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    private func movieBannerView(movie: MovieListItemModel) -> UIView {
        let fullView = UIView()
        fullView.translatesAutoresizingMaskIntoConstraints = true
        
        let movieImage = UIImageView()
        let movieGenre = UILabel()
        let movieTitle = UILabel()
        let mpaRating = PaddedLabel()
        let year = PaddedLabel()
        let time = PaddedLabel()
        let starIcon = UIImageView()
        let rating = UILabel()
        let watchListButton = CustomButton(title: "Add to WatchList", hasBackground: true, fontSize: .small)
        
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieGenre.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        mpaRating.translatesAutoresizingMaskIntoConstraints = false
        year.translatesAutoresizingMaskIntoConstraints = false
        time.translatesAutoresizingMaskIntoConstraints = false
        starIcon.translatesAutoresizingMaskIntoConstraints = false
        rating.translatesAutoresizingMaskIntoConstraints = false
        watchListButton.translatesAutoresizingMaskIntoConstraints = false
        
        fullView.addSubview(movieImage)
        fullView.addSubview(movieTitle)
        fullView.addSubview(movieGenre)
        fullView.addSubview(mpaRating)
        fullView.addSubview(year)
        fullView.addSubview(time)
        fullView.addSubview(starIcon)
        fullView.addSubview(rating)
        fullView.addSubview(watchListButton)
        
        movieImage.setImage(with: movie.poster)
        let genre = genresString(from: movie.genre)
        movieGenre.text = genre
        movieTitle.text = movie.title
        mpaRating.text = movie.mpaRating
        year.text = "\(movie.releaseYear)"
        time.text = movie.duration
        rating.text = "\(movie.rating)"
        
        
        movieImage.pin(to: fullView)
        
        starIcon.leadingAnchor.constraint(equalTo: fullView.leadingAnchor, constant: 16).isActive = true
        starIcon.topAnchor.constraint(equalTo: fullView.topAnchor, constant: 16).isActive = true
        starIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        starIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        // rating constraints
        rating.leadingAnchor.constraint(equalTo: starIcon.trailingAnchor, constant: 8).isActive = true
        rating.centerYAnchor.constraint(equalTo: starIcon.centerYAnchor).isActive = true
                
        // movieTitle constraints
        movieTitle.leadingAnchor.constraint(equalTo: fullView.leadingAnchor, constant: 16).isActive = true
        movieTitle.bottomAnchor.constraint(equalTo: fullView.bottomAnchor, constant: -16).isActive = true
        
        // movieGenre constraints
        movieGenre.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor).isActive = true
        movieGenre.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 8).isActive = true
        
        // mpaRating constraints
        mpaRating.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor).isActive = true
        mpaRating.topAnchor.constraint(equalTo: movieGenre.bottomAnchor, constant: 8).isActive = true
        
        // year constraints
        year.leadingAnchor.constraint(equalTo: mpaRating.trailingAnchor, constant: 8).isActive = true
        year.centerYAnchor.constraint(equalTo: mpaRating.centerYAnchor).isActive = true
        
        // time constraints
        time.leadingAnchor.constraint(equalTo: year.trailingAnchor, constant: 8).isActive = true
        time.centerYAnchor.constraint(equalTo: year.centerYAnchor).isActive = true
        
        // watchListButton constraints
        watchListButton.trailingAnchor.constraint(equalTo: fullView.trailingAnchor, constant: -16).isActive = true
        watchListButton.centerYAnchor.constraint(equalTo: mpaRating.centerYAnchor).isActive = true
        
        return fullView
    }
    
//    func setImageConstraints(movieImage: UIImageView) {
//        movieImage.translatesAutoresizingMaskIntoConstraints = false
//        movieImage.centerXAnchor.constraint(equalTo: stackview.centerXAnchor).isActive = true
//        movieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        movieImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
//        movieImage.widthAnchor.constraint(equalTo: movieImage.heightAnchor, multiplier: 0.75).isActive = true
//    }
    
    private func genresString(from genres: [String]) -> String {
        genres.joined(separator: " • ")
    }
//    private func setupRoundedCornersForLabels() {
//        setupRoundedCorners(for: year)
//        setupRoundedCorners(for: time)
//        setupRoundedCorners(for: mpaRating)
//    }
    
    
}

extension WatchListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
