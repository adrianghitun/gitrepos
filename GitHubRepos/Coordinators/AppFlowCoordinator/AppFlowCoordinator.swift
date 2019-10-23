//
//  AppFlowCoordinator.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 22/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

protocol ExternalURLOpener: class {
    func open(externalURL: URL)
}

/*
 AppFlowCoordinator should manage all the transitions that happens on root - like, switching from unlogged in state to logged in state (starting the RepositoryCoordinator)
 */
class AppFlowCoordinator: WindowFlowCoordinator, StartableFlowCoordinator {
    func start() {
        let coordinator = LaunchScreenCoordinator(with: window)
        coordinator.appFlowCoordinator = self
        coordinator.finishDelegate = self
        startChild(coordinator: coordinator)
    }
}


// MARK: Exposed Logic
/*
Entry point for handling url scheme calls
*/
extension AppFlowCoordinator: ExternalURLOpener {
    func open(externalURL: URL) {
        UIApplication.shared.open(externalURL, options: [:], completionHandler: nil)
    }
}

extension AppFlowCoordinator {
    func handle(url: URL) {
        if let host = url.host, Constants.GitHubOAuth.redirectUri.lowercased().hasSuffix(host),
            let loginCoordinator = childCoordinators.first(where: { $0 is LoginCoordinator }) as? LoginCoordinator {
            loginCoordinator.handleGitHubAuthQuery(url.params)
        }
    }
}

// MARK: LaunchScreenCoordinatorDelegate
extension AppFlowCoordinator: LaunchScreenCoordinatorDelegate {
    func didFinishLaunching() {
        let loginCoordinator = LoginCoordinator(with: window)
        loginCoordinator.externalURLOpener = self
        loginCoordinator.finishDelegate = self
        startChild(coordinator: loginCoordinator)
    }
}

// MARK: LoginCoordinatorDelegate
extension AppFlowCoordinator: LoginCoordinatorDelegate {
    func didLogin() {
        let repositoriesCoordinator = RepositoriesCoordinator(with: window)
        startChild(coordinator: repositoriesCoordinator)
    }
}


