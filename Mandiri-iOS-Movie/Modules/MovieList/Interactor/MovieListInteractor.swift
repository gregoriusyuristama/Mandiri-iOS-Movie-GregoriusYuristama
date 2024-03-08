//
//  MovieListInteractor.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class MovieListInteractor: MovieListInteractorProtocol {
    
    var movieGenre: MovieGenreModel?

    var presenter: (any MovieListPresenterProtocol)?
    
    var manager: any MovieListManagerProtocol
    
    init(manager: any MovieListManagerProtocol) {
        self.manager = manager
    }
    
    func getMovieList() {
        
        guard let movieGenre = movieGenre else { return }
        
        manager.getRemoteMovieList(movieGenre: movieGenre) { movieListResponse, error in
            if let movieListResponse = movieListResponse {
                self.presenter?.interactorDidFetchMovieList(with: .success(movieListResponse))
            } else {
                self.presenter?.interactorDidFetchMovieList(with: .failure(error!))
            }
        }
    }
    
}
