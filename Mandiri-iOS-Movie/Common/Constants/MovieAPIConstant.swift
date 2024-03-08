//
//  MovieAPIConstant.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class MovieAPIConstant {
    static let baseApiURL = "https://api.themoviedb.org/3/"
    static let getMovieGenresURL = "genre/movie/list"
    static let getMovieListFromGenreURL = "discover/movie?with_genres="
    static let getMovieDetailFromListURL = "/movie/"
    static func getMovieVideosURL(_ movieId: Int) -> String {
        return "movie/\(movieId)/videos"
    }
    
    static let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYjU2NzVlMjM4YmZlOTBlYTJlZmE3ZjlkMzBmMjUyYiIsInN1YiI6IjYzZDMwZmQ5NWEwN2Y1MDBkYzllYTFjZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.zD4hklR4DRj-kMlYdojhUBFsGBUPmc84j_z0FdA9DAc"
}
