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
    func getNextPage()
}

class HomeInteractor: HomeInteractorProtocol {

    var presenter: HomePresenterProtocol?
    
    fileprivate var requesting = false
    fileprivate var nextPage: URL?

    func getData() {
        guard !requesting else { return }
        requesting = true
        let repository = HomeDataRepository()
        repository.fetchData { [weak self] result in
            self?.requesting = false
            switch result {
            case .success(let characters):
                guard let characters else { return }
                self?.nextPage = characters.info.next
                self?.presenter?.receiveCharacters(characters: characters.results)
            case .failure(let error):
                self?.presenter?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func getNextPage() {
        guard let nextPage, !requesting else { return }
        requesting = true
        let repository = HomeDataRepository()
        repository.fetchNextPage(page: nextPage) { [weak self] result in
            self?.requesting = false
            switch result {
            case .success(let characters):
                guard let characters else { return }
                self?.nextPage = characters.info.next
                self?.presenter?.receiveNewPage(characters: characters.results)
            case .failure(let error):
                self?.presenter?.showError(message: error.localizedDescription)
            }
        }
    }
}
