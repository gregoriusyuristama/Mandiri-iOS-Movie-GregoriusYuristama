//
//  MovieListInteractor.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class MovieListInteractor: MovieListInteractorProtocol {
    
    var page: Int?
    
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
                self.presenter?.interactorDidFetchMovieList(with: .success(movieListResponse), isPagination: false)
            } else {
                self.presenter?.interactorDidFetchMovieList(with: .failure(error!), isPagination: false)
            }
        }
    }
    
    func loadMoreMovieList() {
        guard let movieGenre = movieGenre, var page = page else {
            // TODO: Handle error when movieGenre nil
            return
        }
        
        page += 1
        self.page = page
        
        manager.getMoreRemoteMovieList(movieGenre: movieGenre, pages: page) { response, error in
            if let response = response {
                self.presenter?.interactorDidFetchMovieList(with: .success(response), isPagination: true)
            } else {
                self.presenter?.interactorDidFetchMovieList(with: .failure(error!), isPagination: true)
            }
        }
    }
    
}
