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

class RepositoriesCoordinator: StartableWindowFlowCoordinator {
    func start() {
        let repositoriesVC = Storyboard.repositories.loadViewController(RepositoriesViewController.self)
        let navVC = CoordinatedNavigationViewController(rootViewController: repositoriesVC)

        repositoriesVC.viewModel = RepositoriesViewModel(service: RepositoriesService(service: BaseService.shared), imageDownloader: ImageDownloader())

        start(with: navVC)
    }
}
