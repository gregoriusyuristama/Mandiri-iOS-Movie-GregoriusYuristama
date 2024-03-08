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
    
    func getMovieListFromGenre(movieGenre: MovieGenreModel, completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        let getMovieListURL = "\(MovieAPIConstant.baseApiURL)\(MovieAPIConstant.getMovieListFromGenreURL)\(movieGenre.id)"
        
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
        let getMovieDetailURL = "\(MovieAPIConstant.baseApiURL)\(MovieAPIConstant.getMovieDetailFromListURL)\(movieList.id)"
        
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
        let getMovieVideoURL = MovieAPIConstant.baseApiURL+MovieAPIConstant.getMovieVideosURL(movieList.id)
        AF.request(getMovieVideoURL, method: .get, headers: self.movieApiHeaders).responseDecodable(of: MovieVideosResponse.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
