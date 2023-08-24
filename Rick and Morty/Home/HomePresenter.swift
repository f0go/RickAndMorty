//
//  HomePresenter.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 23/08/2023.
//  
//

import Foundation

protocol HomePresenterProtocol {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func viewDidLoad()
    func receiveCharacters(characters: [RMCharacter])
    func showError(message: String)
    func didSelectItem(item: RMCharacter)
    func loadCharacters()
    func loadNextPage()
    func receiveNewPage(characters: [RMCharacter])
}

class HomePresenter {
    var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
}

extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        loadCharacters()
    }
    
    func loadCharacters() {
        interactor?.getData()
    }
    
    func receiveCharacters(characters: [RMCharacter]) {
        view?.updateCharacters(characters: characters)
    }
    
    func didSelectItem(item: RMCharacter) {
        router?.showDetail(character: item)
    }
    
    func loadNextPage() {
        interactor?.getNextPage()
    }
    
    func receiveNewPage(characters: [RMCharacter]) {
        view?.loadNextPageCharacters(characters: characters)
    }
    
    func showError(message: String) {
        //TODO: Show error message
        print(message)
    }
}
