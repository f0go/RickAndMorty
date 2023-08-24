//
//  HomeWireFrame.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 23/08/2023.
//  
//

import Foundation
import UIKit

protocol HomeRouterProtocol {
    func showDetail(character: RMCharacter)
}

class HomeRouter: HomeRouterProtocol {
    func showDetail(character: RMCharacter) {
        let vc = DetailAssembler.resolveViewController(character: character)
        guard let navigation = UIApplication.topViewController() as? UINavigationController else { return }
        navigation.pushViewController(vc, animated: true)
    }
}
