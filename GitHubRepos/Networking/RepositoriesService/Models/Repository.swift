//
//  Repository.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    var login: String
    var avatarPath: String

    private enum CodingKeys : String, CodingKey {
        case login, avatarPath = "avatar_url"
    }
}

struct Repository: Decodable {
    var name: String
    var description: String
    var stars: Int
    var owner: Owner

    private enum CodingKeys : String, CodingKey {
        case name, description, owner, stars = "stargazers_count"
    }
}
