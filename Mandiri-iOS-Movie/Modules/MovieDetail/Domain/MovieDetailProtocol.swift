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
    
    func getMovieList()
    func getMovieVideos()
}

protocol MovieDetailPresenterProtocol {
    
    var router: MovieDetailRouterProtocol? { get set }
    var interactor: MovieDetailInteractorProtocol? { get set }
    var view: MovieDetailViewProtocol? { get set }
    
    func interactorDidFetchMovieDetail(with result: Result<MovieDetailModel, Error>)
    func interactorDidFetchMovieVideos(with result: Result<MovieVideosModel, Error>)
}

protocol MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func update(with movieListResponse: MovieDetailModel)
    func update(with error: Error)
    
    func updateYoutubePlayer(with movieVideos: MovieVideosModel)
    func updateYoutubePlayer(with error: Error)
}

protocol MovieDetailRouterProtocol {
    static func createModule(with movieList: MovieListModel) -> UIViewController
}

protocol MovieDetailManagerProtocol {
    func getRemoteMovieDetail(movieList: MovieListModel, completion: @escaping (MovieDetailModel? , Error?) -> ())
    func getRemoteMovieVideos(movieList: MovieListModel, completion: @escaping (MovieVideosResponse?, Error?) -> ())
}
