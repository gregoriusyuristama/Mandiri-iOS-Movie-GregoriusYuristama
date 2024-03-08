//
//  MovieDetailPresenter.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    var router: (any MovieDetailRouterProtocol)?
    
    var interactor: (any MovieDetailInteractorProtocol)? {
        didSet {
            interactor?.getMovieList()
            interactor?.getMovieVideos()
        }
    }
    
    var view: (any MovieDetailViewProtocol)?
    
    func interactorDidFetchMovieDetail(with result: Result<MovieDetailModel, any Error>) {
        switch result {
        case .success(let movieDetail):
            view?.update(with: movieDetail)
        case .failure(let failure):
            view?.update(with: failure)
        }
    }
    
    func interactorDidFetchMovieVideos(with result: Result<MovieVideosModel, any Error>) {
        switch result {
        case .success(let movieVideo):
            view?.updateYoutubePlayer(with: movieVideo)
        case .failure(let failure):
            view?.updateYoutubePlayer(with: failure)
        }
    }
}
