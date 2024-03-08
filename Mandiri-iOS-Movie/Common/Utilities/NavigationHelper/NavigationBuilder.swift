//
//  NavigationBuilder.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation
import UIKit

typealias NavigationFactory = (UIViewController) -> (UINavigationController)

class NavigationBuilder {
    static func build (rootView: UIViewController) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: rootView)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController.viewControllers.first?.navigationItem.title = "Movie Genres"
        
        return navigationController
    }
}
