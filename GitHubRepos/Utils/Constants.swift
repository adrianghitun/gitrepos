//
//  Constants.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 22/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation

struct Constants{
    struct Animations {
        static let defaultAnimationDuration = 0.3
    }

    struct GitHubOAuth {
        static let clientId = "2df685602ce1ac13a36b"
        static let clientSecret = "e13b4b39d7dee34937a6399f2764d09d92485baf"
        static let redirectUri = "githubrepos://finishedGitHubAuth"
        static let scope = "repo"
        static let state = String.randomString(length: 32)
    }
}

extension String {
   static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
