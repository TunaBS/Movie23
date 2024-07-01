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
    var mpaRating = PaddedLabel()
    var year = PaddedLabel()
    var time = PaddedLabel()
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
        setupRoundedCornersForLabels()
        configureStarIcon()
        smallLabelSizeFixing()
        
        setImageConstraints()
        movieGenre.pinToTheRightAndBottomOfSomething(height: 0.1, to: contentView, to: movieImage)
        movieTitle.pinToTheRightAndBottomOfSomething(height: 0.15, to: contentView, to: movieImage, to: movieGenre)
        mpaRating.pinToTheRightAndBottomOfSomething(height: 0.15, to: contentView, to: movieImage, to: movieTitle)
        year.pinToTheRightAndBottomOfSomething(height: 0.15, to: contentView, to: mpaRating, to: movieTitle)
        time.pinToTheRightAndBottomOfSomething(height: 0.15, to: contentView, to: year, to: movieTitle)
        
        watchListButton.pinButtonToBottomTrailing(to: contentView)
        starIcon.pinToTheRightAndBottomOfSomething(height: 0.15, to: contentView, to: movieImage, to: mpaRating)
        rating.pinToTheRightAndBottomOfSomething(height: 0.15, to: contentView, to: starIcon, to: mpaRating)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellValue(movie: MovieListItemModel) {
        movieImage.setImage(with: movie.poster)
        var genreList = genresString(from: movie.genre)
        movieGenre.text = genreList
        movieTitle.text = movie.title
        mpaRating.text = movie.mpaRating == "" ? "N/A" : movie.mpaRating
        year.text = "\(movie.releaseYear)"
        time.text = "\(movie.duration)"
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
        starIcon.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        starIcon.tintColor = .darkerYellow
    }
    
    func smallLabelSizeFixing(){
        year.font = UIFont.systemFont(ofSize: 12)
        time.font = UIFont.systemFont(ofSize: 12)
        mpaRating.font = UIFont.systemFont(ofSize: 12)
        movieGenre.font = UIFont.systemFont(ofSize: 12)
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
    private func setupRoundedCornersForLabels() {
        setupRoundedCorners(for: year)
        setupRoundedCorners(for: time)
        setupRoundedCorners(for: mpaRating)
    }
}
