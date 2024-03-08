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
    
    func getMovieList()
}

protocol MovieListPresenterProtocol {
    
    var router: MovieListRouterProtocol? { get set }
    var interactor: MovieListInteractorProtocol? { get set }
    var view: MovieListViewProtocol? { get set }
    
    func interactorDidFetchMovieList(with result: Result<MovieListResponse, Error>)
    
    func showMovieDetail(_ movieList: MovieListModel)
}

protocol MovieListViewProtocol {
    var presenter: MovieListPresenterProtocol? { get set }
    
    func update(with movieListResponse: MovieListResponse)
    func update(with error: Error)
}

protocol MovieListRouterProtocol {
    
    static func createModule(with movieGenre: MovieGenreModel) -> UIViewController
    
    func presentMovieDetail(from view: MovieListViewProtocol, for movieList: MovieListModel)
}

protocol MovieListManagerProtocol {
    func getRemoteMovieList(movieGenre: MovieGenreModel, completion: @escaping (MovieListResponse? , Error?) -> ())
}
