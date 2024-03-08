//
//  MovieDetailInteractor.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    
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
    
    
}
