//
//  UIImageView+Extensions.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 24/08/2023.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(url: URL) {
        self.image = nil
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                return
            }
            
            guard let imageData = data,
                  let image = UIImage(data: imageData) else {
                print("Can't load image")
                return
            }

            DispatchQueue.main.async {
                self.image = image
            }
        }

        task.resume()
    }
}
