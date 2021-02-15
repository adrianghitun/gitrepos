//
//  RepositoryBranch.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 15/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import Foundation

struct QueryResult<T: Decodable>: Decodable {
    var items: [T]
}

struct RepositoryBranch: Codable {
    var name: String
}
