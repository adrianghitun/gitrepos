//
//  RepositoriesService.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation

class RepositoriesService {
    private var service: BaseServiceProtocol
    static let path: String = "search/repositories"

    init(service: BaseServiceProtocol) {
        self.service = service
    }

    func loadRepositories(completion: @escaping ([Repository]) -> Void) {
        let parameters = [
            "sort":"stars",
            "order":"desc",
            "q":"language=swift&created:>2019-01-01",
            "per_page":"10"
        ]
        
        service.get(path: RepositoriesService.path, parameters: parameters) { (response: Result<RepositoryQuery, Error>) in
            if case .success(let query) = response {
                completion(query.items)
            } else {
                completion([])
            }
        }
    }
}
