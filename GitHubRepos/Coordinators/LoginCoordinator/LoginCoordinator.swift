//
//  LoginCoordinator.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 22/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

protocol LoginCoordinatorDelegate: class {
    func didLogin()
}

class LoginCoordinator: WindowFlowCoordinator, StartableFlowCoordinator {
    var externalURLOpener: ExternalURLOpener?
    var finishDelegate: LoginCoordinatorDelegate?

    var loginViewModel: LoginViewModel?

    func start() {
        let loginVC = Storyboard.login.loadViewController(LoginViewController.self)
        let viewModel = LoginViewModel(service: AuthenticationService(service: BaseService.shared))
        viewModel.delegate = self
        loginVC.viewModel = viewModel
        // Keeping a reference to the viewModel - we may need it later to continue the oauth process
        loginViewModel = viewModel
        start(with: loginVC)
    }

    func handleGitHubAuthQuery(_ query: [String: String]) {
        loginViewModel?.handleGitHubAuthQuery(query)
    }
 }

extension LoginCoordinator: LoginNavigationDelegate {
    func initiateAuthProcess() {
        let clientId = Constants.GitHubOAuth.clientId
        let redirectUri = Constants.GitHubOAuth.redirectUri
        let state = Constants.GitHubOAuth.state
        let scope = Constants.GitHubOAuth.scope

        if let url = URL(string: "https://github.com/login/oauth/authorize?client_id=\(clientId)&redirect_uri=\(redirectUri)&scope=\(scope)&state=\(state)") {
            externalURLOpener?.open(externalURL: url)
        }
    }

    func finishedAuthProcess() {
        finishDelegate?.didLogin()
    }
}
