//
//  DetailView.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 23/08/2023.
//  
//

import Foundation
import UIKit

protocol DetailViewProtocol {
    var presenter: DetailPresenterProtocol? { get set }
    func drawCharacter(character: RMCharacter)
}

class DetailViewController: UIViewController {
    var presenter: DetailPresenterProtocol?
    
    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var charStatusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    enum Constants {
        static let imageCornerRadius: CGFloat = 100
        static let statusAliveRepresentation = ""
        static let statusDeadRepresentation = "😵"
        static let statusUnknownRepresentation = "🤔"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        charImage.layer.cornerRadius = Constants.imageCornerRadius
    }
}

extension DetailViewController: DetailViewProtocol {
    func drawCharacter(character: RMCharacter) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.title = character.name
            self.charImage.setImage(url: character.image)
            switch character.status {
            case .alive: self.charStatusLabel.text = Constants.statusAliveRepresentation
            case .dead: self.charStatusLabel.text = Constants.statusDeadRepresentation
            case .unknown: self.charStatusLabel.text = Constants.statusUnknownRepresentation
            }
            self.descriptionLabel.text = "\(character.name) is a \(character.species) from \(character.origin.name)"
        }
    }
}
