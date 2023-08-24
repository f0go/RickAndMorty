//
//  DetailAssembler.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 23/08/2023.
//

import UIKit

protocol DetailAssembling {
    static func resolveViewController(character: RMCharacter) -> UIViewController
    static func resolvePresenter() -> DetailPresenterProtocol
}

struct DetailAssembler {
    fileprivate enum Constants {
        static let mainStoryboard = "Detail"
        static let DetailViewControllerIdentifier = "Detail"
    }
    
    static func resolveViewController(character: RMCharacter) -> UIViewController {
        let storyboard = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: Constants.DetailViewControllerIdentifier) as? DetailViewController else {
            //TODO: Log error
            return UIViewController()
        }
        let router = DetailRouter()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        viewController.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
        presenter.character = character
        return viewController
    }
}
