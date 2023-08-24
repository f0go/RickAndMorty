//
//  HomeDataRepository.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 24/08/2023.
//

import Foundation

typealias HomeDataRepositoryCompletion = (Result<RMCharacterList?, Error>) -> Void

protocol HomeDataRepositoryProtocol {
    func fetchData(completion: @escaping HomeDataRepositoryCompletion)
    func fetchNextPage(page: URL, completion: @escaping HomeDataRepositoryCompletion)
#if DEBUG
    func fetchMock(completion: @escaping HomeDataRepositoryCompletion)
#endif
}

struct HomeDataRepository: HomeDataRepositoryProtocol {
    enum Endpoints {
        static let getCharacterList = URL(string: "https://rickandmortyapi.com/api/character")
    }
    
    func fetchData(completion: @escaping HomeDataRepositoryCompletion) {
        guard let url = Endpoints.getCharacterList else { return }
        let network = Network()
        network.getDataFromURL(url: url) { result in
            switch result {
            case .success(let data):
                guard let data else { return }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try? decoder.decode(RMCharacterList.self, from: data)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchNextPage(page: URL, completion: @escaping HomeDataRepositoryCompletion) {
        let network = Network()
        network.getDataFromURL(url: page) { result in
            switch result {
            case .success(let data):
                guard let data else { return }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try? decoder.decode(RMCharacterList.self, from: data)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
#if DEBUG
    func fetchMock(completion: @escaping HomeDataRepositoryCompletion) {
        let data = MockDataLoader().loadCharacterList()
        completion(.success(data))
    }
#endif
}
