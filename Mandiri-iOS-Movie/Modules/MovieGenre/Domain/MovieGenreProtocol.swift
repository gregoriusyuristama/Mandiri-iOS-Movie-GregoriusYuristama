//
//  MovieGenreProtocol.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation
import UIKit

typealias EntryPoint = UINavigationController

protocol MovieGenreInteractorProtocol {
    var presenter: MovieGenrePresenterProtocol? { get set }
    var manager: MovieGenreManagerInputProtocol { get set }
    
    func getMovieGenres()
}

protocol MovieGenrePresenterProtocol {
    
    var router: MovieGenreRouterProtocol? { get set }
    var interactor: MovieGenreInteractorProtocol? { get set }
    var view: MovieGenreViewProtocol? { get set }
    
    func interactorDidFetchMovieGenre(with result: Result<MovieGenreResponse, Error>)
    func showMovieList(_ movieGenre: MovieGenreModel)
}

protocol MovieGenreViewProtocol {
    var presenter: MovieGenrePresenterProtocol? { get set }
    
    func update(with movieGenreResponse: MovieGenreResponse)
    func update(with error: Error)
}

protocol MovieGenreRouterProtocol {
    var entry: EntryPoint? { get }
    
    static func createModule(usingNavigationFactory factory: NavigationFactory) -> MovieGenreRouterProtocol
    
    func presentMovieList(from view: MovieGenreViewProtocol, for movieGenre: MovieGenreModel)
    
}

protocol MovieGenreManagerInputProtocol {
    func getRemoteMovieGenres(completion: @escaping (MovieGenreResponse? , Error?) -> ())
}
