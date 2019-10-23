//
//  LoginViewModel.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 22/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation

protocol LoginNavigationDelegate: class {
    func initiateAuthProcess()
    func finishedAuthProcess()
}

class LoginViewModel {
    weak var delegate: LoginNavigationDelegate?

    var service: AuthenticationService

    init(service: AuthenticationService) {
        self.service = service
    }

    var loginButtonTitle: String {
        return "Log In With GitHub"
    }

    func didPressLoginButton() {
        delegate?.initiateAuthProcess()
    }
}

/*
 Entry point for github oauth callback
 */
extension LoginViewModel {
    func handleGitHubAuthQuery(_ query: [String: String]) {
        if let code = query["code"] {
            service.authenticate(with: code) { [weak self] (didSucceed) in
                self?.delegate?.finishedAuthProcess()
            }
        }
    }
}
