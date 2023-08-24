//
//  DetailPresenter.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 23/08/2023.
//  
//

import Foundation

protocol DetailPresenterProtocol {
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
    
    func viewDidLoad()
    func receiveCharacter(character: RMCharacter)
    func showError(message: String)
}

class DetailPresenter {
    var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    
    var character: RMCharacter?
}

extension DetailPresenter: DetailPresenterProtocol {

    func viewDidLoad() {
        loadCharacter()
    }
    
    func loadCharacter() {
        guard let id = character?.id else { return }
        interactor?.getData(id: id)
    }
    
    func receiveCharacter(character: RMCharacter) {
        view?.drawCharacter(character: character)
    }
    
    func showError(message: String) {
        //TODO: Show error message
        print(message)
    }
}
