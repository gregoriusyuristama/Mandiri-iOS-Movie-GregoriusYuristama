//
//  MovieDetailProtocol.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation
import UIKit

protocol MovieDetailInteractorProtocol {
    var presenter: MovieDetailPresenterProtocol? { get set }
    var manager: MovieDetailManagerProtocol { get set }
    var movieList: MovieListModel? { get set }
    var page: Int? { get set }
    
    func getMovieList()
    func getMovieVideos()
    func getUserReviews()
    func getMoreUserReviews()
}

protocol MovieDetailPresenterProtocol {
    
    var router: MovieDetailRouterProtocol? { get set }
    var interactor: MovieDetailInteractorProtocol? { get set }
    var view: MovieDetailViewProtocol? { get set }
    
    var isPaginationAvailable: Bool? { get set }
    
    func interactorDidFetchMovieDetail(with result: Result<MovieDetailModel, Error>)
    func interactorDidFetchMovieVideos(with result: Result<MovieVideosModel, Error>)
    func interactorDidFetchUserReviews(with result: Result<[UserReviewsModel], Error>, isPagination: Bool, isPaginationAvailable: Bool)
    
    func loadMoreUserReviews()
}

protocol MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func update(with movieListResponse: MovieDetailModel)
    func update(with error: Error)
    
    func updateYoutubePlayer(with movieVideos: MovieVideosModel)
    func updateYoutubePlayer(with error: Error)
    
    func updateUserReview(with userReviews: [UserReviewsModel], isPagination: Bool)
    func updateUserReview(with error: Error, isPagination: Bool)
}

protocol MovieDetailRouterProtocol {
    static func createModule(with movieList: MovieListModel) -> UIViewController
}

protocol MovieDetailManagerProtocol {
    func getRemoteMovieDetail(movieList: MovieListModel, completion: @escaping (MovieDetailModel? , Error?) -> ())
    func getRemoteMovieVideos(movieList: MovieListModel, completion: @escaping (MovieVideosResponse?, Error?) -> ())
    func getRemoteUserReviews(movieList: MovieListModel, pages: Int?, completion: @escaping (UserReviewsResponse?, Error?) -> ())
}
