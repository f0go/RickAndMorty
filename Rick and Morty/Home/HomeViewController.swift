//
//  HomeView.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 23/08/2023.
//  
//

import Foundation
import UIKit

protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? { get set }
    func refresh(_ sender: Any)
    func updateCharacters(characters: [RMCharacter])
}

class HomeViewController: UITableViewController, HomeViewProtocol, UISearchResultsUpdating, UISearchBarDelegate {
    fileprivate enum Constants {
        static let cellIdentifier = "CustomCell"
        static let rowHeight: CGFloat = 150
        static let cellImageRadius: CGFloat = 8
        static let pullToRefreshText = "Pull to refresh"
    }
    
    var presenter: HomePresenterProtocol?
    
    fileprivate var characters = [RMCharacter]()
    fileprivate var filteredCharacters = [RMCharacter]()
    
    var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        tableView.rowHeight = Constants.rowHeight
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: Constants.pullToRefreshText)
        refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        searchController = UISearchController()
        searchController?.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}

extension HomeViewController {
    @objc func refresh(_ sender: Any) {
        //Prevent refresh while searchig
        guard !(searchController?.isActive ?? false) else { return }
        print("Refreshing data...")
        presenter?.loadCharacters()
    }
    
    func updateCharacters(characters: [RMCharacter]) {
        self.characters = characters
        filteredCharacters = characters
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl?.endRefreshing()
            self?.tableView.reloadData()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText != "" else {
            filteredCharacters = characters
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            return
        }
        
        filteredCharacters = characters.filter {$0.name.lowercased().contains(searchText.lowercased())}
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? CustomCell else {
            //TODO: Log error
            print("Error: CustomCell Identifier not found")
            return UITableViewCell()
        }
        let character = filteredCharacters[indexPath.row]
        cell.nameLabel.text = character.name
        cell.specieLabel.text = character.species
        cell.originLabel.text = character.origin.name
        cell.charImage.layer.cornerRadius = Constants.cellImageRadius
        cell.charImage.setImage(url: character.image)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(item: filteredCharacters[indexPath.row])
    }
}
