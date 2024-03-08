//
//  MovieDetailRouter.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation
import UIKit

class MovieDetailRouter: MovieDetailRouterProtocol {
    static func createModule(with movieList: MovieListModel) -> UIViewController {
        let router = MovieDetailRouter()
        
        var view: MovieDetailViewProtocol = MovieDetailViewController()
        var presenter: MovieDetailPresenterProtocol = MovieDetailPresenter()
        let movieDetailManager: MovieDetailManagerProtocol = MovieDetailManager()
        var interactor: MovieDetailInteractorProtocol = MovieDetailInteractor(manager: movieDetailManager)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.movieList = movieList
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid View Protocol Type") }
        
        return viewController
    }
    
    
}
