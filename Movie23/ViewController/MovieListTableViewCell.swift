//
//  MovieListTableViewCell.swift
//  Movie23
//
//  Created by BS00880 on 26/6/24.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    var movieImage = UIImageView()
    var movieGenre = UILabel()
    var movieTitle = UILabel()
    var mpaRating = UILabel()
    var year = UILabel()
    var time = UILabel()
    var starIcon = UIImageView()
    var rating = UILabel()
    var watchListButton = CustomButton(title: "Add to WatchList", hasBackground: true, fontSize: .small)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieImage)
        addSubview(movieTitle)
        addSubview(movieGenre)
        addSubview(mpaRating)
        addSubview(year)
        addSubview(time)
        addSubview(starIcon)
        addSubview(rating)
        addSubview(watchListButton)
        
        configureImageView()
        configureGenreView()
        configureTitleView()
        configureStarIcon()
        
        setImageConstraints()
        movieGenre.pinToTheRightAndBottomOfSomething(to: contentView, to: movieImage)
        movieTitle.pinToTheRightAndBottomOfSomething(to: contentView, to: movieImage, to: movieGenre)
        mpaRating.pinToTheRightAndBottomOfSomething(to: contentView, to: movieImage, to: movieTitle)
        year.pinToTheRightAndBottomOfSomething(to: contentView, to: mpaRating, to: movieTitle)
        time.pinToTheRightAndBottomOfSomething(to: contentView, to: year, to: movieTitle)
        
        watchListButton.pinButtonToBottomTrailing(to: contentView)
        starIcon.pinToTheRightAndBottomOfSomething(to: contentView, to: movieImage, to: mpaRating)
        rating.pinToTheRightAndBottomOfSomething(to: contentView, to: starIcon, to: mpaRating)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellValue(movie: Movie) {
        movieImage.image = UIImage(named: "background_dummy_img")
        var genreList = genresString(from: movie.genres)
        movieGenre.text = genreList
        movieTitle.text = movie.title
        mpaRating.text = movie.mpaRating
        year.text = "\(movie.year)"
        time.text = "\(movie.runtime)"
        rating.text = "\(movie.rating)"
        
    }
    
    func configureImageView() {
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
        starIcon.image = UIImage(systemName: "star.fill")
    }
    
    func setImageConstraints() {
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        movieImage.widthAnchor.constraint(equalTo: movieImage.heightAnchor, multiplier: 0.75).isActive = true
    }
    
    private func genresString(from genres: [String]) -> String {
        genres.joined(separator: " • ")
    }
//
//    func setGenreConstraints() {
//        movieGenre.translatesAutoresizingMaskIntoConstraints = false
//        movieGenre.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
//        movieGenre.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 5).isActive = true
//        movieGenre.heightAnchor.constraint(equalToConstant: 20).isActive = true
//    }
//    
//    func setTitleConstraints() {
//        movieTitle.translatesAutoresizingMaskIntoConstraints = false
////        movieTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        movieTitle.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 5).isActive = true
//        movieTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        movieTitle.topAnchor.constraint(equalTo: movieGenre.bottomAnchor, constant: 5).isActive = true
//    }
//    
//    func setMpaConstraints() {
//        mpaRating.translatesAutoresizingMaskIntoConstraints = false
////        mpaRating.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        mpaRating.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 5).isActive = true
//        mpaRating.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        mpaRating.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 5).isActive = true
//    }
    
//    func setYearConstraints() {
//        year.translatesAutoresizingMaskIntoConstraints = false
////        year.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        year.leadingAnchor.constraint(equalTo: mpaRating.trailingAnchor, constant: 5).isActive = true
//        year.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        year.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 5).isActive = true
//    }
//    
//    func setTimeConstraints() {
//        time.translatesAutoresizingMaskIntoConstraints = false
////        time.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        time.leadingAnchor.constraint(equalTo: year.trailingAnchor, constant: 5).isActive = true
//        time.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        time.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 5).isActive = true
//    }
    
//    func setStarIconConstraints() {
//        starIcon.translatesAutoresizingMaskIntoConstraints = false
//        starIcon.centerYAnchor.constraint(equalTo: watchListButton.centerYAnchor).isActive = true
//        starIcon.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 5).isActive = true
//        starIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
////        starIcon.topAnchor.constraint(equalTo: mpaRating.bottomAnchor, constant: 20).isActive = true
//    }
//    
//    func setRatingConstraints() {
//        rating.translatesAutoresizingMaskIntoConstraints = false
//        rating.centerYAnchor.constraint(equalTo: watchListButton.centerYAnchor).isActive = true
//        rating.leadingAnchor.constraint(equalTo: starIcon.trailingAnchor, constant: 5).isActive = true
//        rating.heightAnchor.constraint(equalToConstant: 20).isActive = true
////        rating.topAnchor.constraint(equalTo: mpaRating.bottomAnchor, constant: 20).isActive = true
//    }
}
