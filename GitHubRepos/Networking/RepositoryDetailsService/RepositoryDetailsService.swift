//
//  RepositoryDetailsService.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 12/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import Foundation

protocol RepositoryDetailsServiceProtocol {
    func branches(for repository: Repository, completion: @escaping ([RepositoryBranch]) -> Void)
    func contributors(for repository: Repository, completion: @escaping ([RepositoryContributor]) -> Void)
}

class RepositoryDetailsService: RepositoryDetailsServiceProtocol {
    private var service: BaseServiceProtocol
    
    func basePath(for repository: Repository) -> String {
        return "repos/\(repository.owner.login)/\(repository.name)"
    }

    init(service: BaseServiceProtocol) {
        self.service = service
    }
    
    func branches(for repository: Repository, completion: @escaping ([RepositoryBranch]) -> Void) {
        let fullPath = basePath(for: repository) + "/branches"
        service.get(path: fullPath, parameters: [:])
        { (response: Result<[RepositoryBranch], Error>) in
            if case .success(let query) = response {
                completion(query)
            } else {
                completion([])
            }
        }
    }
    
    func contributors(for repository: Repository, completion: @escaping ([RepositoryContributor]) -> Void) {
        let fullPath = basePath(for: repository) + "/contributors"
        service.get(path: fullPath, parameters: [:])
        { (response: Result<[RepositoryContributor], Error>) in
            if case .success(let query) = response {
                completion(query)
            } else {
                completion([])
            }
        }
    }
}

class RepositoryServiceDummy: RepositoryDetailsServiceProtocol {
    func branches(for repository: Repository, completion: @escaping ([RepositoryBranch]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion([RepositoryBranch(name: "Master"), RepositoryBranch(name: "Dev")])
        }
    }
    
    func contributors(for repository: Repository, completion: @escaping ([RepositoryContributor]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion([RepositoryContributor(login: "Adrian"), RepositoryContributor(login: "Alex")])
        }
    }
}
