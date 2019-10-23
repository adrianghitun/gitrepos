//
//  RepositoryCellViewModel.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation

protocol RepositoryImageProviderProtocol: class {
    func image(for repository: Repository, completion: @escaping (Any?) -> Void)
}

class RepositoryCellViewModel {
    let model: Repository
    weak var imageProvider: RepositoryImageProviderProtocol?

    init(with model: Repository) {
        self.model = model
    }

    var title: String {
        return "⭑\(model.stars)\n" + model.name
    }

    var description: String {
        return model.description
    }

    func image(completion: @escaping (Any?) -> Void) {
        imageProvider?.image(for: model, completion: completion)
    }
}
