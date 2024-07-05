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
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .cyan
        return sv
    } ()
    
    private let contentView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .darkerYellow
        return cv
    } ()
    
    let movieImage = UIImageView()
    let movieGenre = UILabel()
    let movieTitle = UILabel()
    let mpaRating = PaddedLabel()
    let year = PaddedLabel()
    let time = PaddedLabel()
    let descriptionOfMovie = UILabel()
    let starIcon = UIImageView()
    var movieRating: Double = 0.0
    let watchListButton = CustomButton(title: "Add to WatchList", hasBackground: true, fontSize: .small)
    var setRatingView = UIView()
    var castView = UIView()
    var castValue: [Cast]? = nil
    
    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        super.viewDidLoad()
        guard let movieId = movieId else {
            return
        }
        viewModel = MovieDetailsViewModel(movieRepositoy: MovieRepositoryImpl(apiService: APIServiceImplemention(apiClient: APIClientImp())), movieId: movieId)
        bindViewModel()
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
        
        contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
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
        self.contentView.addSubview(castView)
        
        configureAllValues()
        
        
        movieGenre.pinToRightAndBottomOfSomething(height: 15, to: self.contentView, to: nil, to: movieImage)
        movieTitle.pinToRightAndBottomOfSomething(height: 20, to: self.contentView, to: nil, to: movieGenre)
        mpaRating.pinToRightAndBottomOfSomething(height: 25, to: self.contentView, to: nil, to: movieTitle)
        year.pinToRightAndBottomOfSomething(height: 25, to: self.contentView, to: mpaRating, to: movieTitle)
        time.pinToRightAndBottomOfSomething(height: 25, to: self.contentView, to: year, to: movieTitle)
        descriptionOfMovie.pinToRightAndBottomOfSomething(height: 50, to: self.contentView, to: nil, to: mpaRating)
//        watchListButtonAlignment()
        watchListButton.pinToBottomOfSomethingCenter(height: 50, to: self.contentView, to: descriptionOfMovie)
        setRatingView.pinToBottomOfSomethingCenter(height: 80, to: self.contentView, to: watchListButton)
//        castText.pinToRightAndBottomOfSomething(height: 18, to: self.contentView, to: nil, to: setRatingView)
        castView.pinToRightAndBottomOfSomething(height: 60, to: self.contentView, to: nil, to: setRatingView)
//        castView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    private func configureAllValues() {

        configureImageView()
        setImageConstraints()
        configureTitleView()
        configureGenreView()
        smallLabelSizeFixing()
        setupRoundedCornersForLabels()
        
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
        let defaultCast = [Cast.ifNoCastDataAvailable]
        setMovieValues(movie: viewModel?.movieDetails ?? MovieDetailsModel(id: 10, title: "", description: "", largeCoverImage: "", releaseYear: 2012, rating: 8.0, duration: "", mpaRating: "", genres: ["",""], descriptionFull: "", cast: defaultCast))
    }
    
    func setMovieValues(movie: MovieDetailsModel) {
        movieImage.setImage(with: movie.largeCoverImage)
        var genreList = genresString(from: movie.genres)
        movieGenre.text = genreList
        movieTitle.text = movie.title
        mpaRating.text = movie.mpaRating == "" ? "N/A" : movie.mpaRating
        year.text = "\(movie.releaseYear)"
        time.text = movie.duration == "" ? "N/A" : movie.duration
        movieRating = movie.rating
        descriptionOfMovie.text = movie.descriptionFull == "" ? "N/A" : movie.descriptionFull
        castValue = movie.cast
        print("Movie rating: \(movie.rating)")
        movieRating = movie.rating
        
        // Now that movieRating is set, we can call setUpRatingView
//        setRatingView.removeFromSuperview() // Remove the old rating view if it exists
//        setRatingView = setUpRatingView(to: self.contentView, to: watchListButton, movieRatingValue: movieRating)
        setUpRatingView(movieRatingValue: movieRating).pin(to: setRatingView)

        
//        castView.removeFromSuperview()
//        castView = setUpCastView(to: self.contentView, to: setRatingView, cast: castValue)
//        setUpCastView(cast: castValue).pin(to: castView)
//        self.contentView.addSubview(castView)
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
        movieTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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
        movieImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        movieImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        movieImage.heightAnchor.constraint(equalTo: movieImage.widthAnchor, multiplier: 1.3).isActive = true
        movieImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.75).isActive = true
    }
    
    func watchListButtonAlignment() {
        watchListButton.translatesAutoresizingMaskIntoConstraints = false
        watchListButton.topAnchor.constraint(equalTo: descriptionOfMovie.bottomAnchor, constant: 10).isActive = true
        watchListButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        watchListButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    private func setUpRatingView(/*to contentView: UIView,*/ /*to watchlistButton: UIView,*/ movieRatingValue: Double) -> UIView {
        let fullView = UIView()
        fullView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(fullView)
        
        var firstRatingView = setUpSingleRatingView(to: fullView, header: "Overall Rating", ratingValue: movieRatingValue)
        var secondRatingView = setUpSingleRatingView(to: fullView, header: "Your Rating", ratingValue: 0.0)
        firstRatingView.leadingAnchor.constraint(equalTo: fullView.leadingAnchor).isActive = true
        secondRatingView.trailingAnchor.constraint(equalTo: fullView.trailingAnchor, constant: 5).isActive = true
        
//        fullView.pin(to: contentView)
//        superview.topAnchor.constraint(equalTo: watchlistButton.bottomAnchor, constant: 10).isActive = true
//        superview.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
////        superview.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
//        superview.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
////        superview.pinToBottomOfSomethingCenter(height: 50, to: contentView, to: watchlistButton)
        
        return fullView
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
    
    private func setUpCastView(/*to superView: UIView, to bottomOf: UIView, */cast: [Cast]?) -> UIView {
        let fullView = UIView()
        fullView.translatesAutoresizingMaskIntoConstraints = false
        
        let headingLabel = UILabel()
        headingLabel.text = String("Cast")
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(headingLabel)
        
        let scrollCastView = UIScrollView()
        scrollCastView.showsHorizontalScrollIndicator = false
        scrollCastView.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(scrollCastView)
        
        let castStackView = UIStackView()
        castStackView.axis = .horizontal
        castStackView.backgroundColor = .red          //use color for testing
        castStackView.distribution = .equalSpacing
        castStackView.spacing = 5
        castStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollCastView.addSubview(castStackView)
        
        castStackView.pin(to: scrollCastView)
        castStackView.heightAnchor.constraint(equalTo: scrollCastView.heightAnchor).isActive = true
//        castView.addSubview(scrollCastView)
//        scrollCastView.pin(to: castView)
        
        for cast in 0..<5 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imageView.image = UIImage(named: "cast_dummy_img")
            castStackView.addArrangedSubview(imageView)
        }
//        if let cast = /*movie.*/cast {
//            for castMember in cast {
//                let imageView = UIImageView()
//                imageView.contentMode = .scaleAspectFit
//                if let urlString = castMember.urlSmallImage {
//                    imageView.setImage(with: urlString)
//                } else {
//                    imageView.image = UIImage(named: "cast_dummy_img")
//                }
//                castStackView.addArrangedSubview(imageView)
//            }
//        }
        
//        fullView.addSubview(scrollCastView)
//        scrollCastView.pin(to: fullView)
//        scrollCastView.heightAnchor.constraint(equalTo: fullView.heightAnchor).isActive = true
        headingLabel.topAnchor.constraint(equalTo: fullView.topAnchor).isActive = true
        headingLabel.leadingAnchor.constraint(equalTo: fullView.leadingAnchor).isActive = true
        scrollCastView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor).isActive = true
        scrollCastView.leadingAnchor.constraint(equalTo: fullView.leadingAnchor).isActive = true
        scrollCastView.bottomAnchor.constraint(equalTo: fullView.bottomAnchor).isActive = true
        scrollCastView.trailingAnchor.constraint(equalTo: fullView.trailingAnchor).isActive = true
        
        scrollCastView.widthAnchor.constraint(equalTo: fullView.widthAnchor).isActive = true
//        superView.addSubview(fullView)
//        fullView.translatesAutoresizingMaskIntoConstraints = false
//        fullView.topAnchor.constraint(equalTo: bottomOf.bottomAnchor, constant: 10).isActive = true
//        //scrollCastView.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
//        fullView.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
//        fullView.heightAnchor.constraint(equalToConstant: 120).isActive = true
//        fullView.widthAnchor.constraint(equalTo: superView.widthAnchor).isActive = true
        return fullView
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
