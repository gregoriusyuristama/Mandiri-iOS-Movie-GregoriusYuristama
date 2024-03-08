//
//  MovieListManager.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class MovieListManager: MovieListManagerProtocol {
    
    func getRemoteMovieList(movieGenre: MovieGenreModel, completion: @escaping (MovieListResponse?, (any Error)?) -> ()) {
        MovieAPI.shared.getMovieListFromGenre(movieGenre: movieGenre) { result in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }
    
    func getMoreRemoteMovieList(movieGenre: MovieGenreModel, pages: Int, completion: @escaping (MovieListResponse?, (any Error)?) -> ()) {
        MovieAPI.shared.getMovieListFromGenre(movieGenre: movieGenre, pages: pages) { result in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }
}
