//
//  MovieDetailInteractor.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    var page: Int?
    
    var presenter: (any MovieDetailPresenterProtocol)?
    
    var manager: any MovieDetailManagerProtocol
    
    var movieList: MovieListModel?
    
    init(manager: any MovieDetailManagerProtocol) {
        self.manager = manager
    }
    
    func getMovieList() {
        guard let movieList = movieList else { return }
        
        manager.getRemoteMovieDetail(movieList: movieList) { movieDetailResponse, error in
            if let movieDetailResponse = movieDetailResponse {
                self.presenter?.interactorDidFetchMovieDetail(with: .success(movieDetailResponse))
            } else {
                self.presenter?.interactorDidFetchMovieDetail(with: .failure(error!))
            }
        }
    }
    
    func getMovieVideos() {
        guard let movieList = movieList else { return }
        
        manager.getRemoteMovieVideos(movieList: movieList) { movieVideosResponse, error in
            if let movieVideosResponse = movieVideosResponse {
                guard let movieTrailer = movieVideosResponse.results.first(where: {$0.site?.lowercased() == "youtube" && $0.type?.lowercased() == "trailer"}) else {
                    self.presenter?.interactorDidFetchMovieVideos(with: .failure(YoutubeError.invalidId))
                    return
                }
                self.presenter?.interactorDidFetchMovieVideos(with: .success(movieTrailer))
            } else {
                self.presenter?.interactorDidFetchMovieDetail(with: .failure(error!))
            }
        }
    }
    
    func getUserReviews() {
        guard let movieList = movieList, let page = page else { return }
        
        manager.getRemoteUserReviews(movieList: movieList, pages: nil) { response, error in
            if let response = response {
                self.presenter?.interactorDidFetchUserReviews(with: .success(response.results), isPagination: false, isPaginationAvailable: (page < response.totalPages))
            } else {
                self.presenter?.interactorDidFetchUserReviews(with: .failure(error!), isPagination: false, isPaginationAvailable: false)
            }
        }
    }
    
    func getMoreUserReviews() {
        guard let movieList = movieList, var page = page else { return }
        
        page += 1
        self.page = page
        
        manager.getRemoteUserReviews(movieList: movieList, pages: page) { response, error in
            if let response = response {
                self.presenter?.interactorDidFetchUserReviews(with: .success(response.results), isPagination: true, isPaginationAvailable: (page < response.totalPages))
            } else {
                self.presenter?.interactorDidFetchUserReviews(with: .failure(error!), isPagination: true, isPaginationAvailable: false)
            }
        }
    }
    
    
}
