//
//  DetailInteractor.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 23/08/2023.
//  
//

import Foundation

protocol DetailInteractorProtocol {
    var presenter: DetailPresenterProtocol? { get set }
    func getData(id: Int)
}

class DetailInteractor: DetailInteractorProtocol {

    var presenter: DetailPresenterProtocol?

    func getData(id: Int) {
        let repository = DetailDataRepository()
        repository.fetchData(id: id) { [weak self] result in
            switch result {
            case .success(let character):
                guard let character else { return }
                self?.presenter?.receiveCharacter(character: character)
            case .failure(let error):
                self?.presenter?.showError(message: error.localizedDescription)
            }
        }
    }
}
