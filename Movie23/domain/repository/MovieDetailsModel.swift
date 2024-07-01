//
//  MovieDetailsModel.swift
//  Movie23
//
//  Created by BS00880 on 1/7/24.
//

import Foundation


struct MovieDetailsModel {
    let id: Int
    let title: String
    let description: String
    let largeCoverImage: String
    let releaseYear: Int
    let rating: Double
    let duration: String
    let mpaRating: String
    let genres: [MovieGenre]
    var isFavourite: Bool = false
    
    
    static func fromMovie(movie: MovieDetailsResponse.Movie, isFavourite: Bool = false) -> MovieDetailsModel {
        return MovieDetailsModel(
            id: movie.id,
            title: movie.title,
            description: movie.descriptionFull,
            largeCoverImage: movie.largeCoverImage,
            releaseYear: movie.year,
            rating: movie.rating,
            duration: convertMinutesToHoursAndMinutes(minutes: movie.runtime),
            mpaRating: movie.mpaRating,
            genres: movie.genres.map({ MovieGenre.fromString($0) }),
            isFavourite: isFavourite
        )
    }
    
//    func toMovieListItem() -> MovieListItemModel {
//        return MovieListItemModel(
//            id: id,
//            title: title,
//            poster: largeCoverImage,
//            rating: rating,
//            releaseYear: releaseYear,
//            mpaRating: mpaRating,
//            duration: duration,
//            isFavourite: isFavourite
//        )
//    }
}
