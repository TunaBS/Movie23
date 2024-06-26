//
//  Movie.swift
//  Movie23
//
//  Created by BS00880 on 21/6/24.
//

import Foundation
struct Movie : Codable, Hashable, Identifiable{
   
    
    let id : Int
    let title : String
    let year : Int
    let rating : Double
    let runtime : Int
    let genres : [String]
    let descriptionFull : String
    let backgroundImage : String
    let largeCoverImage :  String
    let mpaRating: String
    let cast: [Cast]?
    
    static var movieShowForTest = Movie(id: 10, title: "", year: 0, rating: 0, runtime: 0, genres: ["", ""], descriptionFull: "", backgroundImage: "background_dummy_img", largeCoverImage: "background_dummy_img", mpaRating: "", cast: [Cast.castForTest, Cast.castForTest, Cast.castForTest])
    
    static var movieArrayShowForTest = [
        Movie(id: 11, title: "No Title Found", year: 2012, rating: 8.7, runtime: 255, genres: ["", ""], descriptionFull: "No Description Found", backgroundImage: "background_dummy_img", largeCoverImage: "background_dummy_img", mpaRating: "N/A2012", cast: [Cast.castForTest, Cast.castForTest, Cast.castForTest]),
        Movie(id: 12, title: "No Title Found", year: 0, rating: 0, runtime: 0, genres: ["", ""], descriptionFull: "", backgroundImage: "background_dummy_img", largeCoverImage: "background_dummy_img", mpaRating: "", cast: [Cast.castForTest, Cast.castForTest, Cast.castForTest]),
        Movie(id: 13, title: "", year: 0, rating: 0, runtime: 0, genres: ["", ""], descriptionFull: "", backgroundImage: "background_dummy_img", largeCoverImage: "background_dummy_img", mpaRating: "", cast: [Cast.castForTest, Cast.castForTest, Cast.castForTest]),
        Movie(id: 14, title: "", year: 0, rating: 0, runtime: 0, genres: ["", ""], descriptionFull: "", backgroundImage: "background_dummy_img", largeCoverImage: "background_dummy_img", mpaRating: "", cast: [Cast.castForTest, Cast.castForTest, Cast.castForTest]),
        Movie(id: 15, title: "", year: 0, rating: 0, runtime: 0, genres: ["", ""], descriptionFull: "", backgroundImage: "background_dummy_img", largeCoverImage: "background_dummy_img", mpaRating: "", cast: [Cast.castForTest, Cast.castForTest, Cast.castForTest]),
        Movie(id: 16, title: "", year: 0, rating: 0, runtime: 0, genres: ["", ""], descriptionFull: "", backgroundImage: "background_dummy_img", largeCoverImage: "background_dummy_img", mpaRating: "", cast: [Cast.castForTest, Cast.castForTest, Cast.castForTest])
    ]
}
