//
//  MovieDetailsViewController.swift
//  Movie23
//
//  Created by BS00880 on 27/6/24.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
//        sv.backgroundColor = .darkerYellow
        return sv
    } ()
    
    private let contentView: UIView = {
        let cv = UIView()
//        cv.backgroundColor = .darkerYellow
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

    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        super.viewDidLoad()
        setUpScrollView()
    }
    
    private func setUpScrollView() {
        self.view.addSubview(scrollView)
        scrollView.pin(to: view)
        
        self.scrollView.addSubview(contentView)
        contentView.pin(to: scrollView)
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: -20),
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
//        self.view.addSubview(rating)
        self.contentView.addSubview(watchListButton)
        
        setMovieValues(movie: MovieDetailsResponse.Movie.movieShowForTest1)
        
        configureImageView()
        setImageConstraints()
        configureTitleView()
        configureGenreView()
//        configureStarIcon()
        smallLabelSizeFixing()
        setupRoundedCornersForLabels()
        
        movieGenre.pinToTheRightAndBottomOfSomething(height: 0.015, to: self.contentView, to: nil, to: movieImage)
        movieTitle.pinToTheRightAndBottomOfSomething(height: 0.02, to: self.contentView, to: nil, to: movieGenre)
        mpaRating.pinToTheRightAndBottomOfSomething(height: 0.025, to: self.contentView, to: nil, to: movieTitle)
        year.pinToTheRightAndBottomOfSomething(height: 0.025, to: self.contentView, to: mpaRating, to: movieTitle)
        time.pinToTheRightAndBottomOfSomething(height: 0.025, to: self.contentView, to: year, to: movieTitle)
        descriptionOfMovie.pinToTheRightAndBottomOfSomething(height: 0.05, to: self.contentView, to: nil, to: mpaRating)
        watchListButtonAlignment()
        setUpRatingView(to: contentView, to: watchListButton)
        
    }
    
    func setMovieValues(movie: MovieDetailsResponse.Movie) {
        movieImage.image = UIImage(named: "background_dummy_img")
        var genreList = genresString(from: movie.genres)
        movieGenre.text = genreList
        movieTitle.text = movie.title
        mpaRating.text = movie.mpaRating
        year.text = "\(movie.year)"
        time.text = "\(movie.runtime)"
//        rating.text = "\(movie.rating)"
        movieRating = movie.rating
        descriptionOfMovie.text = movie.descriptionFull
        
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
    
    private func setUpRatingView(to contentView: UIView, to watchlistButton: UIView) {
        let superview = UIView()
        superview.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(superview)
        
        var firstRatingView = setUpSingleRatingView(to: superview, header: "Overall Rating", ratingValue: movieRating)
        var secondRatingView = setUpSingleRatingView(to: superview, header: "Your Rating", ratingValue: 0.0)
        
        firstRatingView.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        secondRatingView.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 5).isActive = true
        
        superview.topAnchor.constraint(equalTo: watchlistButton.bottomAnchor, constant: 10).isActive = true
        superview.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        superview.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1).isActive = true
        superview.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
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

        headingLabel.topAnchor.constraint(equalTo: ratingView.topAnchor).isActive = true
        headingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor).isActive = true
        ratingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10).isActive = true
        ratingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor).isActive = true
        
        ratingView.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.5).isActive = true
        
        return ratingView
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
