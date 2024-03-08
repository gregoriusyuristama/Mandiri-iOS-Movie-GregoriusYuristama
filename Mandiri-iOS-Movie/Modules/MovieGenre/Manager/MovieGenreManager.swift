//
//  MovieGenreManager.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class MovieGenreManager: MovieGenreManagerInputProtocol {
    func getRemoteMovieGenres(completion: @escaping (MovieGenreResponse?, (any Error)?) -> ()) {
        MovieAPI.shared.getMovieGenres { result in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }
}
