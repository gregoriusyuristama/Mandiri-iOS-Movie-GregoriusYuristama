//
//  MovieDetailManager.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class MovieDetailManager: MovieDetailManagerProtocol {

    func getRemoteMovieVideos(movieList: MovieListModel, completion: @escaping (MovieVideosResponse?, (any Error)?) -> ()) {
        MovieAPI.shared.getMovieVideos(from: movieList) { result in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }
    
    func getRemoteMovieDetail(movieList: MovieListModel, completion: @escaping (MovieDetailModel?, (any Error)?) -> ()) {
        MovieAPI.shared.getMovieDetailFromList(from: movieList) { result in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }    
    
    func getRemoteUserReviews(movieList: MovieListModel, pages: Int? = nil, completion: @escaping (UserReviewsResponse?, (any Error)?) -> ()) {
        MovieAPI.shared.getUserReviews(from: movieList, pages: pages) { result in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }
    
    
    
}
