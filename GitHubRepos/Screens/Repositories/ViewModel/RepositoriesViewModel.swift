//
//  RepositoriesViewModel.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation

protocol RepositoriesViewModelDelegate {
    func didUpdateDatasource()
    func didFinishLoading()
}

class RepositoriesViewModel {
    let service: RepositoriesService
    let imageDownloader: ImageDownloaderProtocol

    var dataSource: [Repository] = [] {
        didSet{
            delegate?.didUpdateDatasource()
        }
    }

    /*
     Simulating databinding with a delegate that would notify the view to
     hide its activity indicator and reload its view
     */
    var delegate: RepositoriesViewModelDelegate?

    init(service: RepositoriesService, imageDownloader: ImageDownloaderProtocol) {
        self.service = service
        self.imageDownloader = imageDownloader
    }

    func loadRepositories() {
        service.loadRepositories { [weak self] (repositories) in
            self?.delegate?.didFinishLoading()
            self?.dataSource = repositories.sorted(by: { $0.stars > $1.stars })
        }
    }
}

// MARK: Image Fetch Logic - RepositoryImageProviderProtocol
extension RepositoriesViewModel: RepositoryImageProviderProtocol {
    func image(for repository: Repository, completion: @escaping (Any?) -> Void) {
        let owner = repository.owner

        if let url = URL(string: owner.avatarPath) {
            imageDownloader.image(for: url, completion: completion)
        }
    }
}

// MARK: - DataSource
extension RepositoriesViewModel {
    var numberOfSections: Int {
        return 1
    }

    var numberOfItems: Int {
        return dataSource.count
    }

    func item(for row: Int) -> RepositoryCellViewModel {
        let repository = dataSource[row]
        let cellViewModel = RepositoryCellViewModel(with: repository)
        cellViewModel.imageProvider = self
        return cellViewModel
    }
}
