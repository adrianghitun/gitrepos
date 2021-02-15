//
//  RepositoriesCoordinator.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

typealias StartableWindowFlowCoordinator = WindowFlowCoordinator & StartableFlowCoordinator

protocol RepositorySelectionDelegate {
    func didSelect(_ repository: Repository)
}

class RepositoriesCoordinator: StartableWindowFlowCoordinator {
    var navigationController: UINavigationController?
    
    func start() {
        let repositoriesVC = Storyboard.repositories.loadViewController(RepositoriesViewController.self)
        let navVC = CoordinatedNavigationViewController(rootViewController: repositoriesVC)

        let viewModel = RepositoriesViewModel(service: RepositoriesService(service: BaseService.shared), imageProvider: RepositoryImageProvider(imageDownloader: ImageDownloader()))
        repositoriesVC.viewModel = viewModel
        viewModel.selectionDelegate = self

        start(with: navVC)
        navigationController = navVC
    }
    
    private func openDetailsScreen(for repository: Repository) {
        let detailsVC = Storyboard.repositories.loadViewController(RepositoryDetailsViewController.self)
        let service = RepositoryDetailsService(service: BaseService.shared)
        detailsVC.viewModel = RepositoryDetailsViewModel(service: service,
                                                         imageProvider: RepositoryImageProvider(imageDownloader: ImageDownloader()),
                                                         repository: repository)
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension RepositoriesCoordinator: RepositorySelectionDelegate {
    func didSelect(_ repository: Repository) {
        openDetailsScreen(for: repository)
    }
}
