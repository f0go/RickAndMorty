//
//  UIApplication+Extensions.swift
//  Rick and Morty
//
//  Created by Mauro Urani on 24/08/2023.
//

import Foundation
import UIKit

extension UIApplication {
    class func topViewController() -> UIViewController? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let rootViewController = sceneDelegate.window?.rootViewController {
            var topViewController = rootViewController
            while let presentedViewController = topViewController.presentedViewController {
                topViewController = presentedViewController
            }
            return topViewController
        }
        return nil
    }
}
