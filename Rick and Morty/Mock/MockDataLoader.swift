//
//  MockDataLoader.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 24/08/2023.
//

import Foundation

class MockDataLoader {
    func loadCharacterList() -> RMCharacterList {
        let path = Bundle.main.path(forResource: "CharacterList", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try! decoder.decode(RMCharacterList.self, from: data)
    }
    
    func loadCharacter() -> RMCharacter {
        let path = Bundle.main.path(forResource: "Character", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try! decoder.decode(RMCharacter.self, from: data)
    }
}
