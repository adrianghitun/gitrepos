//
//  Storyboard.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 22/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

enum Storyboard: String {
    case login = "Login"
    case launch = "LaunchScreen"
    case repositories = "Repositories"
}

extension Storyboard {
    var rootViewController: UIViewController? {
        return current.instantiateInitialViewController()
    }

    var initialViewController: UIViewController? {
        return current.instantiateInitialViewController()
    }

    func loadViewController<T>(_ vcClass: T.Type) -> T {
        if let loadedVC = current.instantiateViewController(withIdentifier: String(describing: T.self)) as? T {
            return loadedVC
        }
        fatalError("View Controller does not have the same Storyboard identifier as its class name")
    }

    private var current: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: nil)
    }
}
