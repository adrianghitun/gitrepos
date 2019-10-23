//
//  LaunchScreenCoordinator.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 22/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

protocol LaunchScreenCoordinatorDelegate: class {
    func didFinishLaunching()
}

class LaunchScreenCoordinator: WindowFlowCoordinator, StartableFlowCoordinator {
    var appFlowCoordinator: AppFlowCoordinator?
    weak var finishDelegate: LaunchScreenCoordinatorDelegate?

    func start() {
        let screen = LaunchViewController()
        start(with: screen)

        /*
         Simulating some background work - maybe checking for previous session?
         */
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

            self.finishDelegate?.didFinishLaunching()
        }
    }
}
