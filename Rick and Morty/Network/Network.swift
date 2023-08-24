//
//  API.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 24/08/2023.
//

import Foundation

class Network {
    
    typealias NetworkCompletion = (Result<Data?, Error>) -> Void
    
    func getDataFromURL(url: URL, completion: @escaping NetworkCompletion) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error de respuesta del servidor")
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
