//
//  HomeAssembler.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 23/08/2023.
//

import UIKit

protocol HomeAssembling {
    static func resolveViewController() -> UIViewController
    static func resolvePresenter() -> HomePresenterProtocol
}

struct HomeAssembler {
    fileprivate enum Constants {
        static let mainStoryboard = "Home"
        static let homeViewControllerIdentifier = "Home"
    }
    
    static func resolveViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: Constants.homeViewControllerIdentifier) as? HomeViewController else {
            //TODO: Log error
            return UIViewController()
        }
        let router = HomeRouter()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        viewController.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
        return viewController
    }
}
