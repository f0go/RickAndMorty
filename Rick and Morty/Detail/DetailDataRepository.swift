//
//  DetailDataRepository.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 24/08/2023.
//

import Foundation

typealias DetailDataRepositoryCompletion = (Result<RMCharacter?, Error>) -> Void

protocol DetailDataRepositoryProtocol {
    func fetchData(id: Int, completion: @escaping DetailDataRepositoryCompletion)
#if DEBUG
    func fetchMock(completion: @escaping DetailDataRepositoryCompletion)
#endif
}

struct DetailDataRepository: DetailDataRepositoryProtocol {
    
    enum Endpoints {
        static let getCharacter = URL(string: "https://rickandmortyapi.com/api/character")
    }
    
    func fetchData(id: Int, completion: @escaping DetailDataRepositoryCompletion) {
        guard let url = Endpoints.getCharacter?.appending(path: "\(id)") else { return }
        let network = Network()
        network.getDataFromURL(url: url) { result in
            switch result {
            case .success(let data):
                guard let data else { return }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try? decoder.decode(RMCharacter.self, from: data)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
#if DEBUG
    func fetchMock(completion: @escaping DetailDataRepositoryCompletion) {
        let data = MockDataLoader().loadCharacter()
        completion(.success(data))
    }
#endif
}
