//
//  MovieGenrePresenter.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class MovieGenrePresenter: MovieGenrePresenterProtocol {

    var router: MovieGenreRouterProtocol?
    
    var interactor: MovieGenreInteractorProtocol? {
        didSet {
            interactor?.getMovieGenres()
        }
    }
    
    var view: MovieGenreViewProtocol?
    
    func interactorDidFetchMovieGenre(with result: Result<MovieGenreResponse, any Error>) {
        switch result {
        case .success(let movieResponse):
            view?.update(with: movieResponse)
        case .failure(let failure):
            view?.update(with: failure)
        }
    }
    
    func showMovieList(_ movieGenre: MovieGenreModel) {
        guard let view = view else { return }
        router?.presentMovieList(from: view, for: movieGenre)
    }
    
}
