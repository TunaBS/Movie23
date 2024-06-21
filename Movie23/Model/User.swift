//
//  User.swift
//  Movie23
//
//  Created by BS00880 on 21/6/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String?
    let userName: String?
    var movies : [Movie]?
    static var userShowForTest = User(id: "abcd", email: "helloworld@gmail.com", userName: "Fairuz Ahmed Tuna", movies: Movie.movieArrayShowForTest)
}
