//
//  MovieDetailPresenter.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var isPaginationAvailable: Bool?
    
    var router: (any MovieDetailRouterProtocol)?
    
    var interactor: (any MovieDetailInteractorProtocol)? {
        didSet {
            interactor?.getMovieList()
            interactor?.getMovieVideos()
            interactor?.getUserReviews()
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
    
    func interactorDidFetchUserReviews(with result: Result<[UserReviewsModel], any Error>, isPagination: Bool, isPaginationAvailable: Bool) {
        self.isPaginationAvailable = isPaginationAvailable
        switch result {
        case .success(let userReviews):
            view?.updateUserReview(with: userReviews, isPagination: isPagination)
        case .failure(let failure):
            view?.updateUserReview(with: failure, isPagination: isPagination)
        }
    }
    
    func loadMoreUserReviews() {
        interactor?.getMoreUserReviews()
    }
}
