//
//  MovieDetailsViewController.swift
//  Movie23
//
//  Created by BS00880 on 27/6/24.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movieId: Int?
    var viewModel: MovieDetailsViewModel?
    /*let viewModel = MovieDetailsViewModel(movieRepositoy: MovieRepositoryImpl(apiService: APIServiceImplemention(apiClient: APIClientImp())), movieId: movieId)*/
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
//        sv.backgroundColor = .darkerYellow
        return sv
    } ()
    
    private let contentView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .darkerYellow
        return cv
    } ()
    
    var movieImage = UIImageView()
    var movieGenre = UILabel()
    var movieTitle = UILabel()
    var mpaRating = PaddedLabel()
    var year = PaddedLabel()
    var time = PaddedLabel()
    var descriptionOfMovie = UILabel()
    var starIcon = UIImageView()
    var movieRating = Double()
    var watchListButton = CustomButton(title: "Add to WatchList", hasBackground: true, fontSize: .small)
    var setRatingView = UIView()
    var castText = UILabel()

    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        super.viewDidLoad()
        guard let movieId = movieId else {
            return
        }
        viewModel = MovieDetailsViewModel(movieRepositoy: MovieRepositoryImpl(apiService: APIServiceImplemention(apiClient: APIClientImp())), movieId: movieId)
        setUpScrollView()
    }
    
    private func setUpScrollView() {
//        self.view.addSubview(scrollView)
//        scrollView.pin(to: view)
//        
//        self.scrollView.addSubview(contentView)
//        contentView.pin(to: scrollView)
//        
//        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
//        hConst.isActive = true
//        hConst.priority = UILayoutPriority(50)
//        
//        NSLayoutConstraint.activate([
//            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: -20),
//        ])
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor/*, constant: 10*/),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor/*, constant: -10*/),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor/*, constant: -20*/),
            
            
        ])
        
        setUpUIInsideScrollView()
    }
    
    private func setUpUIInsideScrollView() {
        self.contentView.addSubview(movieImage)
        self.contentView.addSubview(movieTitle)
        self.contentView.addSubview(movieGenre)
        self.contentView.addSubview(mpaRating)
        self.contentView.addSubview(year)
        self.contentView.addSubview(time)
        self.contentView.addSubview(descriptionOfMovie)
        self.contentView.addSubview(starIcon)
        self.contentView.addSubview(watchListButton)
        self.contentView.addSubview(setRatingView)
        self.contentView.addSubview(castText)
        
        bindViewModel()

        configureImageView()
        setImageConstraints()
        configureTitleView()
        configureGenreView()
//        configureStarIcon()
        smallLabelSizeFixing()
        setupRoundedCornersForLabels()
        setRatingView = setUpRatingView(to: self.contentView, to: watchListButton)
        
        
        movieGenre.pinToRightAndBottomOfSomething(height: 15, to: self.contentView, to: nil, to: movieImage)
        movieTitle.pinToRightAndBottomOfSomething(height: 20, to: self.contentView, to: nil, to: movieGenre)
        mpaRating.pinToRightAndBottomOfSomething(height: 25, to: self.contentView, to: nil, to: movieTitle)
        year.pinToRightAndBottomOfSomething(height: 25, to: self.contentView, to: mpaRating, to: movieTitle)
        time.pinToRightAndBottomOfSomething(height: 25, to: self.contentView, to: year, to: movieTitle)
        descriptionOfMovie.pinToRightAndBottomOfSomething(height: 50, to: self.contentView, to: nil, to: mpaRating)
        watchListButtonAlignment()
        setRatingView.pinToBottomOfSomethingCenter(height: 60, to: self.contentView, to: watchListButton)
        castText.pinToRightAndBottomOfSomething(height: 18, to: self.contentView, to: nil, to: setRatingView)
        self.castText.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.movieDetailsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.setMovie()
            }
        }
    }
    
    private func setMovie() {
        setMovieValues(movie: viewModel?.movieDetails ?? MovieDetailsModel(id: 10, title: "", description: "", largeCoverImage: "", releaseYear: 2012, rating: 8.0, duration: "", mpaRating: "", genres: ["",""], descriptionFull: ""))
    }
    
    func setMovieValues(movie: MovieDetailsModel) {
        movieImage.setImage(with: movie.largeCoverImage)
//        movieImage.image = UIImage(named: "background_dummy_img")
        var genreList = genresString(from: movie.genres)
        movieGenre.text = genreList
//        movieGenre.text = "nothing"
        movieTitle.text = movie.title
        mpaRating.text = movie.mpaRating == "" ? "N/A" : movie.mpaRating
        year.text = "\(movie.releaseYear)"
//        time.text = "\(movie.duration)"
        time.text = movie.duration == "" ? "N/A" : movie.duration
//        rating.text = "\(movie.rating)"
        movieRating = movie.rating
        descriptionOfMovie.text = movie.descriptionFull
        castText.text = "Cast"
    }
    
    func configureImageView() {
//        movieImage.image = UIImage(named: "background_dummy_img")
        movieImage.layer.cornerRadius = 10
        movieImage.clipsToBounds = true
    }
    
    func configureGenreView() {
        movieGenre.numberOfLines = 0
        movieGenre.lineBreakMode = .byWordWrapping
    }
    
    func configureTitleView() {
        movieTitle.numberOfLines = 0
        movieTitle.font = UIFont.boldSystemFont(ofSize: movieTitle.font.pointSize)
    }
    
    func configureStarIcon() {
        starIcon.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        starIcon.tintColor = .darkerYellow
    }
    
    func smallLabelSizeFixing(){
        year.font = UIFont.systemFont(ofSize: 12)
        time.font = UIFont.systemFont(ofSize: 12)
        mpaRating.font = UIFont.systemFont(ofSize: 12)
        movieGenre.font = UIFont.systemFont(ofSize: 12)
        descriptionOfMovie.font = UIFont.systemFont(ofSize: 12)
    }
    
    func setImageConstraints() {
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        movieImage.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 10).isActive = true
        movieImage.heightAnchor.constraint(equalTo: movieImage.widthAnchor, multiplier: 1.3).isActive = true
        movieImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
    }
    
    func watchListButtonAlignment() {
        watchListButton.translatesAutoresizingMaskIntoConstraints = false
        watchListButton.topAnchor.constraint(equalTo: descriptionOfMovie.bottomAnchor, constant: 10).isActive = true
        watchListButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        watchListButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    private func setUpRatingView(to contentView: UIView, to watchlistButton: UIView) -> UIView {
        let superview = UIView()
//        superview.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(superview)
        
        var firstRatingView = setUpSingleRatingView(to: superview, header: "Overall Rating", ratingValue: movieRating)
        var secondRatingView = setUpSingleRatingView(to: superview, header: "Your Rating", ratingValue: 6.7)
        
        firstRatingView.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        secondRatingView.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 5).isActive = true
        
//        superview.topAnchor.constraint(equalTo: watchlistButton.bottomAnchor, constant: 10).isActive = true
//        superview.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        superview.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        superview.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        return superview
    }
    
    private func setUpSingleRatingView(to superview: UIView, header: String, ratingValue: Double) -> UIView {
        let ratingView = UIView()
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(ratingView)
        
        let headingLabel = UILabel()
        headingLabel.text = String(header)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingView.addSubview(headingLabel)
        
        let ratingLabel = UILabel()
        ratingLabel.text = String(ratingValue)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingView.addSubview(ratingLabel)
        
        let starView = setTheStars(to: ratingView, ratingValue: ratingValue)
        ratingView.addSubview(starView)

        headingLabel.topAnchor.constraint(equalTo: ratingView.topAnchor).isActive = true
        headingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor).isActive = true
        ratingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10).isActive = true
        ratingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor).isActive = true
        starView.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor).isActive = true
        starView.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor).isActive = true
        
        ratingView.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.5).isActive = true
        
        return ratingView
    }
    
    private func setTheStars(to superview: UIView, ratingValue: Double) -> UIView {
        let starView = UIView()
        starView.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(starView)
        
        let starStackView = UIStackView()
        starStackView.axis = .horizontal
        starStackView.distribution = .fillEqually
        starStackView.spacing = 0.5
        
        let filledStarImage = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        let emptyStarImage = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate)
        let halfStarImage = UIImage(systemName: "star.leadinghalf.filled")?.withRenderingMode(.alwaysTemplate)
        
        let filledStarCount = Int(ratingValue/2)
        let halfStar = ratingValue.truncatingRemainder(dividingBy: 2) >= 1
        
        for index in 0..<5 {
            var imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            
            if index < filledStarCount {
                imageView.image = filledStarImage
            } else if index == filledStarCount && halfStar {
                imageView.image = halfStarImage
            } else {
                imageView.image = emptyStarImage
            }
            starStackView.addArrangedSubview(imageView)
        }
        starView.addSubview(starStackView)
        starStackView.pin(to: starView)
        
        starView.widthAnchor.constraint(equalTo: superview.widthAnchor).isActive = true
        return starView
    }
    
    private func genresString(from genres: [String]) -> String {
        genres.joined(separator: " • ")
    }
    private func setupRoundedCornersForLabels() {
        view.setupRoundedCorners(for: year)
        view.setupRoundedCorners(for: time)
        view.setupRoundedCorners(for: mpaRating)
    }
}
