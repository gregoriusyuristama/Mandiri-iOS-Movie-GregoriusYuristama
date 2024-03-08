//
//  MoveListPresenter.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class MovieListPresenter: MovieListPresenterProtocol {
    var router: (any MovieListRouterProtocol)?
    
    var interactor: (any MovieListInteractorProtocol)? {
        didSet {
            interactor?.getMovieList()
        }
    }
    
    var view: (any MovieListViewProtocol)?
    
    func interactorDidFetchMovieList(with result: Result<MovieListResponse, any Error>) {
        switch result {
        case .success(let movieListResponse):
            view?.update(with: movieListResponse)
        case .failure(let failure):
            view?.update(with: failure)
        }
    }
    
    func showMovieDetail(_ movieList: MovieListModel) {
        guard let view = view else { return }
        router?.presentMovieDetail(from: view, for: movieList)
    }
    
}
