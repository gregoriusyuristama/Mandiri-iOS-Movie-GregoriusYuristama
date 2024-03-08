//
//  MovieListProtocol.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation
import UIKit

protocol MovieListInteractorProtocol {
    var presenter: MovieListPresenterProtocol? { get set }
    var manager: MovieListManagerProtocol { get set }
    var movieGenre: MovieGenreModel? { get set }
    var page: Int? { get set }
    
    func getMovieList()
    func loadMoreMovieList()
}

protocol MovieListPresenterProtocol {
    
    var router: MovieListRouterProtocol? { get set }
    var interactor: MovieListInteractorProtocol? { get set }
    var view: MovieListViewProtocol? { get set }
    
    func interactorDidFetchMovieList(with result: Result<MovieListResponse, Error>, isPagination: Bool)
    
    func showMovieDetail(_ movieList: MovieListModel)
    
    func loadMoreMovies()
}

protocol MovieListViewProtocol {
    var presenter: MovieListPresenterProtocol? { get set }
    
    func update(with movieListResponse: MovieListResponse, isPagination: Bool)
    func update(with error: Error, isPagination: Bool)
}

protocol MovieListRouterProtocol {
    
    static func createModule(with movieGenre: MovieGenreModel) -> UIViewController
    
    func presentMovieDetail(from view: MovieListViewProtocol, for movieList: MovieListModel)
}

protocol MovieListManagerProtocol {
    func getRemoteMovieList(movieGenre: MovieGenreModel, completion: @escaping (MovieListResponse? , Error?) -> ())
    func getMoreRemoteMovieList(movieGenre: MovieGenreModel, pages: Int, completion: @escaping (MovieListResponse? , Error?) -> ())
}
