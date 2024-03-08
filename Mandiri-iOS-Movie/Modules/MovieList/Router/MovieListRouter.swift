//
//  MovieListRouter.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation
import UIKit

class MovieListRouter: MovieListRouterProtocol {

    
    static func createModule(with movieGenre: MovieGenreModel) -> UIViewController{
        let router = MovieListRouter()
        
        var view: MovieListViewProtocol = MovieListViewController()
        var presenter: MovieListPresenterProtocol = MovieListPresenter()
        let movieListManager = MovieListManager()
        var interactor: MovieListInteractorProtocol = MovieListInteractor(manager: movieListManager)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.movieGenre = movieGenre
        interactor.page = 1
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid view protocol Type") }
        
        
        return viewController
    }
    
    func presentMovieDetail(from view: any MovieListViewProtocol, for movieList: MovieListModel) {
        let movieListViewController = MovieDetailRouter.createModule(with: movieList)
        guard let viewController = view as? UIViewController else { fatalError("Invalid view controller type")}
        
        movieListViewController.navigationItem.title = movieList.title
        
        viewController.navigationController?.pushViewController(movieListViewController, animated: true)
    }
    
    
}
