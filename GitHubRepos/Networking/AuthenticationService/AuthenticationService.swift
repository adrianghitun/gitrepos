//
//  LoginService.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation

class AuthenticationService {
    private var service: BaseService
    static let path: String = "login/oauth"

    init(service: BaseService) {
        self.service = service
    }

    func authenticate(with code: String, completion: @escaping (Bool) -> Void) {
        let fullPath = AuthenticationService.path + "/access_token"
            let parameters = [
                "client_id" : Constants.GitHubOAuth.clientId,
                "client_secret" : Constants.GitHubOAuth.clientSecret,
                "state" : Constants.GitHubOAuth.state,
                "code" : code
            ]

        let authBaseUrl = URL(string:  "https://github.com/")
        service.post(baseUrl: authBaseUrl, path: fullPath, parameters: parameters) { (response: Swift.Result<AccessToken, Error>) in
            if case .success(let token) = response {
                self.service.setupAuthorization(with: token)
                print(token)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}

struct AccessToken: Decodable {
    var access_token: String
}
