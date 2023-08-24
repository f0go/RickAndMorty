//
//  HomeInteractor.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 23/08/2023.
//  
//

import Foundation

protocol HomeInteractorProtocol {
    var presenter: HomePresenterProtocol? { get set }
    func getData()
}

class HomeInteractor: HomeInteractorProtocol {

    var presenter: HomePresenterProtocol?

    func getData() {
        let repository = HomeDataRepository()
        repository.fetchData { [weak self] result in
            switch result {
            case .success(let characters):
                guard let characters else { return }
                self?.presenter?.receiveCharacters(characters: characters.results)
            case .failure(let error):
                self?.presenter?.showError(message: error.localizedDescription)
            }
        }
    }
}
