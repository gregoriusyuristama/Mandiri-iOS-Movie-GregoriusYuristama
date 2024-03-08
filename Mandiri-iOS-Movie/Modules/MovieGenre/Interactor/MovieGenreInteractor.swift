//
//  MovieGenreInteractor.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class MovieGenreInteractor: MovieGenreInteractorProtocol {
    var presenter: (any MovieGenrePresenterProtocol)?
    
    var manager: MovieGenreManagerInputProtocol
    
    init(manager: any MovieGenreManagerInputProtocol) {
        self.manager = manager
    }
    
    func getMovieGenres() {
        manager.getRemoteMovieGenres { movieGenreResponse, error in
            if let movieGenreResponse = movieGenreResponse {
                self.presenter?.interactorDidFetchMovieGenre(with: .success(movieGenreResponse))
            } else {
                self.presenter?.interactorDidFetchMovieGenre(with: .failure(error!))
            }
        }
    }
}
