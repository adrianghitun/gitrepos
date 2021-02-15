//
//  RepositoriesViewModel.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation

class RepositoryImageProvider: RepositoryImageProviderProtocol {
    let imageDownloader: ImageDownloaderProtocol
    
    init(imageDownloader: ImageDownloaderProtocol) {
        self.imageDownloader = imageDownloader
    }
    
    func image(for repository: Repository, completion: @escaping (Any?) -> Void) {
        let owner = repository.owner

        if let url = URL(string: owner.avatarPath) {
            imageDownloader.image(for: url, completion: completion)
        }
    }
}

class RepositoriesViewModel: TableViewViewModel {
    let service: RepositoriesService
    let imageProvider: RepositoryImageProviderProtocol

    var selectionDelegate: RepositorySelectionDelegate?

    init(service: RepositoriesService, imageProvider: RepositoryImageProviderProtocol) {
        self.service = service
        self.imageProvider = imageProvider
    }
    
    override func setupDataSource() {
        dataSource = [TableSection()]
    }
    
    var repositoriesSection: TableSection {
        return dataSource[0]
    }
    
    func loadRepositories() {
        self.dataState = .loading
        service.loadRepositories { [weak self] (repositories) in
            self?.repositoriesSection.cells = repositories.sorted(by: { $0.stars > $1.stars }).map({
                let viewModel = RepositoryCellViewModel(with: $0)
                viewModel.imageProvider = self?.imageProvider
                return viewModel
            })
            self?.dataState = .loaded
        }
    }
    
    override func selectItem(at index: IndexPath) {
        if let item = item(at: index) as? RepositoryCellViewModel {
            selectionDelegate?.didSelect(item.model)
        }
    }
}
