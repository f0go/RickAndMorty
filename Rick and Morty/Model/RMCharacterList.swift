//
//  RMCharacterList.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 24/08/2023.
//

import Foundation

struct RMCharacterList: Codable {
    let results: [RMCharacter]
    let next: URL?
    let prev: URL?
}
