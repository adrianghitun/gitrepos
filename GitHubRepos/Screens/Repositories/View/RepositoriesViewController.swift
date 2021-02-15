//
//  RepositoryViewController.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

class RepositoriesViewController: CoordinatedTableViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override var cellMappings: [HashableType : UITableViewCell.Type] {
                [HashableType(RepositoryCellViewModel.self): RepositoryCell.self]
    }
    
    var repositoriesViewModel: RepositoriesViewModel? {
        return viewModel as? RepositoriesViewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        repositoriesViewModel?.loadRepositories()
    }

    func setupTableView() {
        tableView.tableFooterView = UIView()
    }
    
    override func dataStateDidChanged(_ state: DataState) {
        switch state {
        case .initialising, .loading:
            activityIndicator?.startAnimating()
        case .loaded:
            activityIndicator?.stopAnimating()
            tableView?.reloadData()
        }
    }
}
