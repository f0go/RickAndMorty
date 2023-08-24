//
//  RMCharacter.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 23/08/2023.
//

import Foundation

struct RMCharacter: Codable {
    let id: Int
    let name: String
    let species: String
    let origin: Origin
    let image: URL
    let url: URL
    let status: Status
    
    enum Status: String, Codable {
        case alive
        case dead
        case unknown
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)

            switch rawValue {
            case "Alive":
                self = .alive
            case "Dead":
                self = .dead
            case "unknown":
                self = .unknown
            default:
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unknown value")
            }
        }
    }
    
    struct Origin: Codable {
        let name: String
        let url: URL?
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<RMCharacter.Origin.CodingKeys> = try decoder.container(keyedBy: RMCharacter.Origin.CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.url = try? container.decodeIfPresent(URL.self, forKey: .url)
        }
    }
}
