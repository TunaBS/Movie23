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
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView
    } ()
    
    private let stackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
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
            
//            pageControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
//            pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 30),
            pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8)
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
        fullView.backgroundColor = .systemBackground
        fullView.translatesAutoresizingMaskIntoConstraints = true
        
        var movieImage = UIImageView()
        movieImage.setImage(with: movie.backgroundImage)
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        let ratingView = ratingView(movieRating: movie.rating)
        let lowerView = lowerViewOfBannerView(movie: movie)
        
        fullView.addSubview(movieImage)
        fullView.addSubview(ratingView)
        fullView.addSubview(lowerView)
        
        movieImage.pin(to: fullView)
        ratingView.topAnchor.constraint(equalTo: fullView.topAnchor, constant: 10).isActive = true
        ratingView.leadingAnchor.constraint(equalTo: fullView.leadingAnchor, constant: 10).isActive = true
        
        lowerView.centerXAnchor.constraint(equalTo: fullView.centerXAnchor).isActive = true
        lowerView.bottomAnchor.constraint(equalTo: fullView.bottomAnchor).isActive = true
        lowerView.widthAnchor.constraint(equalTo: fullView.widthAnchor).isActive = true
        
        return fullView
    }
    
    private func ratingView(movieRating: Double) -> UIView {
        let fullView = UIView()
        fullView.translatesAutoresizingMaskIntoConstraints = false
        
        var starIcon = UIImageView(image: UIImage(systemName: "star.fill"))
        var rating = UILabel()
        starIcon.translatesAutoresizingMaskIntoConstraints = false
        rating.translatesAutoresizingMaskIntoConstraints = false
        
        starIcon.tintColor = .darkText
        rating.text = "\(movieRating)"
        rating.font = .systemFont(ofSize: 14)
        
        fullView.addSubview(starIcon)
        fullView.addSubview(rating)
        
        starIcon.leadingAnchor.constraint(equalTo: fullView.leadingAnchor).isActive = true
        starIcon.centerYAnchor.constraint(equalTo: fullView.centerYAnchor).isActive = true
        starIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        starIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        rating.leadingAnchor.constraint(equalTo: starIcon.trailingAnchor, constant: 8).isActive = true
        rating.centerYAnchor.constraint(equalTo: fullView.centerYAnchor).isActive = true
        rating.trailingAnchor.constraint(equalTo: fullView.trailingAnchor).isActive = true
        rating.bottomAnchor.constraint(equalTo: fullView.bottomAnchor).isActive = true
        
        let paddedView = createPaddedContainer(
            for: fullView,
            padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5),
            cornerRadius: 5.0,
            borderWidth: 0.5,
            borderColor: .darkText,
            backgroundColor: .transparentGrayColor
        )
        
        return paddedView
    }
    
    private func lowerViewOfBannerView(movie: MovieListItemModel) -> UIView {
        let fullView = UIView()
        fullView.translatesAutoresizingMaskIntoConstraints = true
        
        var movieGenre = UILabel()
        var movieTitle = UILabel()
        var mpaRating = PaddedLabel()
        var year = PaddedLabel()
        var time = PaddedLabel()
        let watchListButton = CustomButton(title: "Add to WatchList", hasBackground: true, fontSize: .small)
        
        movieGenre.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        mpaRating.translatesAutoresizingMaskIntoConstraints = false
        year.translatesAutoresizingMaskIntoConstraints = false
        time.translatesAutoresizingMaskIntoConstraints = false
        watchListButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        fullView.addSubview(movieTitle)
        fullView.addSubview(movieGenre)
        fullView.addSubview(mpaRating)
        fullView.addSubview(year)
        fullView.addSubview(time)
        fullView.addSubview(watchListButton)
        
        let genre = genresString(from: movie.genre)
        movieGenre.text = genre
        movieTitle.text = movie.title
        mpaRating.text = movie.mpaRating == "" ? "N/A" : movie.mpaRating
        year.text = "\(movie.releaseYear)"
        time.text = movie.duration
        
        movieTitle.font = .boldSystemFont(ofSize: 20)
        movieTitle.numberOfLines = 1
        movieTitle.lineBreakMode = .byTruncatingTail
        
        movieGenre.font = .systemFont(ofSize: 14)
        movieGenre.numberOfLines = 1
        movieGenre.lineBreakMode = .byTruncatingTail
        
        mpaRating.font = .systemFont(ofSize: 12)
        fullView.setupRoundedCorners(for: mpaRating)
        year.font = .systemFont(ofSize: 12)
        fullView.setupRoundedCorners(for: year)
        time.font = .systemFont(ofSize: 12)
        fullView.setupRoundedCorners(for: time)

        
        
        movieGenre.leadingAnchor.constraint(equalTo: fullView.leadingAnchor).isActive = true
        movieGenre.topAnchor.constraint(equalTo: fullView.topAnchor).isActive = true
        movieGenre.trailingAnchor.constraint(equalTo: watchListButton.leadingAnchor, constant: -8).isActive = true
        
        movieTitle.leadingAnchor.constraint(equalTo: fullView.leadingAnchor).isActive = true
        movieTitle.topAnchor.constraint(equalTo: movieGenre.bottomAnchor, constant: 8).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo: watchListButton.leadingAnchor, constant: -8).isActive = true
        
        mpaRating.leadingAnchor.constraint(equalTo: fullView.leadingAnchor).isActive = true
        mpaRating.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 8).isActive = true
        
        year.leadingAnchor.constraint(equalTo: mpaRating.trailingAnchor, constant: 8).isActive = true
        year.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 8).isActive = true
        
        time.leadingAnchor.constraint(equalTo: year.trailingAnchor, constant: 8).isActive = true
        time.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 8).isActive = true
        time.bottomAnchor.constraint(equalTo: fullView.bottomAnchor, constant: -8).isActive = true
        
//        watchListButton.leadingAnchor.constraint(greaterThanOrEqualTo: time.trailingAnchor, constant: 10).isActive = true
        watchListButton.widthAnchor.constraint(equalTo: fullView.widthAnchor, multiplier: 0.4).isActive = true
        watchListButton.trailingAnchor.constraint(equalTo: fullView.trailingAnchor, constant: -5).isActive = true
        watchListButton.centerYAnchor.constraint(equalTo: fullView.centerYAnchor).isActive = true
        
        let paddedView = createPaddedContainer(
            for: fullView,
            padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            cornerRadius: 5.0,
            borderWidth: 2.0,
            borderColor: .darkText,
            backgroundColor: .transparentGrayColor
        )
        
        return paddedView
    }
    /*
    private func movieBannerView(movie: MovieListItemModel) -> UIView {
        let fullView = UIView()
        fullView.translatesAutoresizingMaskIntoConstraints = true
        
        var movieImage = UIImageView()
        var movieGenre = UILabel()
        var movieTitle = UILabel()
        var mpaRating = PaddedLabel()
        var year = PaddedLabel()
        var time = PaddedLabel()
        var starIcon = UIImageView(image: UIImage(systemName: "star.fill"))
        var rating = UILabel()
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
        
        movieImage.setImage(with: movie.backgroundImage)
        let genre = genresString(from: movie.genre)
        movieGenre.text = genre
        movieTitle.text = movie.title
        mpaRating.text = movie.mpaRating
        year.text = "\(movie.releaseYear)"
        time.text = movie.duration
        rating.text = "\(movie.rating)"
        
        //configuring views
        movieImage.contentMode = .scaleAspectFill
        movieImage.clipsToBounds = true
        movieImage.layer.cornerRadius = 20
        
        movieTitle.font = .boldSystemFont(ofSize: 20)
        movieTitle.numberOfLines = 1
        
        movieGenre.font = .systemFont(ofSize: 16)
        movieGenre.numberOfLines = 1
        
        rating.font = .systemFont(ofSize: 14)
        starIcon.tintColor = .darkerYellow
        
        mpaRating.font = .systemFont(ofSize: 14)
        mpaRating.layer.borderWidth = 1
        mpaRating.layer.cornerRadius = 5
        mpaRating.layer.borderColor = UIColor.black.cgColor
        mpaRating.textAlignment = .center
        mpaRating.clipsToBounds = true
        
        year.font = .systemFont(ofSize: 14)
        year.layer.borderWidth = 1
        year.layer.cornerRadius = 5
        year.layer.borderColor = UIColor.black.cgColor
        year.textAlignment = .center
        year.clipsToBounds = true
        
        time.font = .systemFont(ofSize: 14)
        time.layer.borderWidth = 1
        time.layer.cornerRadius = 5
        time.layer.borderColor = UIColor.black.cgColor
        time.textAlignment = .center
        time.clipsToBounds = true
        //configured views
        
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
     */
    
    private func configureView (with movie: MovieListItemModel) {
        
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
