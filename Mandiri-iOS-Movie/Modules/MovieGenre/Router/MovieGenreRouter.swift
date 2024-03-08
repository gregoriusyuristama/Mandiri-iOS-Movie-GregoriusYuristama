//
//  MovieGenreRouter.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation
import UIKit

class MovieGenreRouter: MovieGenreRouterProtocol {
    var entry: EntryPoint?
    
    static func createModule(usingNavigationFactory factory: (UIViewController) -> (UINavigationController)) -> any MovieGenreRouterProtocol {
        let router = MovieGenreRouter()
        
        var view: MovieGenreViewProtocol = MovieGenreViewController()
        var presenter: MovieGenrePresenterProtocol = MovieGenrePresenter()
        let movieGenreManager = MovieGenreManager()
        var interactor: MovieGenreInteractorProtocol = MovieGenreInteractor(manager: movieGenreManager)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let viewEntry = view as? UIViewController else { fatalError("Invalid UI Type") }
        
        router.entry = factory(viewEntry)
        
        return router
    }
    
    func presentMovieList(from view: any MovieGenreViewProtocol, for movieGenre: MovieGenreModel) {
        let movieListViewController = MovieListRouter.createModule(with: movieGenre)
        guard let viewController = view as? UIViewController else { fatalError("Invalid view controller type")}
        
        movieListViewController.navigationItem.title = movieGenre.name
        
        viewController.navigationController?.pushViewController(movieListViewController, animated: true)
    }
    
    
}
