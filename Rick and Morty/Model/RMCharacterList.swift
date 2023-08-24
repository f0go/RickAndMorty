//
//  RMCharacterList.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 24/08/2023.
//

import Foundation

struct RMCharacterList: Codable {
    let results: [RMCharacter]
    let info: Info
    
    struct Info: Codable {
        let next: URL?
    }
}
