//
//  FavouriteMovieDatabaseModel.swift
//  Movie23
//
//  Created by BS00880 on 1/7/24.
//

import Foundation

import SwiftData

class FavouriteMovieDatabaseModel {
    var id: Int
    var title: String
    var poster: String
    var rating: Double
    var releaseYear: Int

    init(id: Int, title: String, poster: String, rating: Double, releaseYear: Int) {
        self.id = id
        self.title = title
        self.poster = poster
        self.rating = rating
        self.releaseYear = releaseYear
    }
}
