//
//  Rick_and_MortyTests.swift
//  Rick and MortyTests
//
//  Created by Mauro Urani on 23/08/2023.
//

import XCTest
@testable import Rick_and_Morty

final class Rick_and_MortyTests: XCTestCase {

    func testGetCharacterList() throws {
        HomeDataRepository().fetchMock { result in
            switch result {
            case .success(let list):
                XCTAssertNotNil(list)
                let character = list?.results.first
                XCTAssertNotNil(character)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    func testGetCharacter() throws {
        DetailDataRepository().fetchMock { result in
            switch result {
            case .success(let character):
                XCTAssertNotNil(character)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
}
