//
//  MovieAPI.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation
import Alamofire

class MovieAPI {
    static var shared = MovieAPI()
    
    private var movieApiHeaders = HTTPHeaders([
        HTTPHeader(name: "Authorization", value: "Bearer \(MovieAPIConstant.accessToken)")
    ])
    
    func getMovieGenres(completion: @escaping (Result<MovieGenreResponse, Error>) -> Void) {
        let getMovieGenreURL = MovieAPIConstant.baseApiURL+MovieAPIConstant.getMovieGenresURL
        
        AF.request(getMovieGenreURL, method: .get, headers: self.movieApiHeaders).responseDecodable(of: MovieGenreResponse.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getMovieListFromGenre(movieGenre: MovieGenreModel, pages: Int? = nil, completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        var getMovieListURL = "\(MovieAPIConstant.baseApiURL)\(MovieAPIConstant.getMovieListFromGenreURL)\(movieGenre.id)"
        
        if let pages {
            getMovieListURL += "&page=\(pages)"
        }
        
        AF.request(getMovieListURL, method: .get, headers: self.movieApiHeaders).responseDecodable(of: MovieListResponse.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getMovieDetailFromList(from movieList: MovieListModel, completion: @escaping (Result<MovieDetailModel, Error>) -> Void ) {
        guard let movieId = movieList.id else { return }
        let getMovieDetailURL = "\(MovieAPIConstant.baseApiURL)\(MovieAPIConstant.getMovieDetailFromListURL)\(movieId)"
        
        AF.request(getMovieDetailURL, method: .get, headers: self.movieApiHeaders).responseDecodable(of: MovieDetailModel.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getMovieVideos(from movieList: MovieListModel, completion: @escaping (Result<MovieVideosResponse, Error>) -> Void ) {
        guard let movieId = movieList.id else { return }
        let getMovieVideoURL = MovieAPIConstant.getMovieVideosURL(movieId)
        AF.request(getMovieVideoURL, method: .get, headers: self.movieApiHeaders).responseDecodable(of: MovieVideosResponse.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getUserReviews(from movieList: MovieListModel, pages: Int? = nil, completion: @escaping (Result<UserReviewsResponse, Error>) -> Void) {
        guard let movieId = movieList.id else { return }
        
        let getUserReviewsURL = MovieAPIConstant.getUserReviewsURL(movieId)
        
        AF.request(getUserReviewsURL, method: .get, headers: self.movieApiHeaders).responseDecodable(of: UserReviewsResponse.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
    }
}
