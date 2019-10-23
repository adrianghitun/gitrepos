//
//  RepositoryViewController.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

class RepositoriesViewController: CoordinatedViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    var viewModel: RepositoriesViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        activityIndicator.startAnimating()
        viewModel?.loadRepositories()
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

extension RepositoriesViewController: RepositoriesViewModelDelegate {
    func didUpdateDatasource() {
        tableView.reloadSections(IndexSet(integer: 0), with: .fade)
    }

    func didFinishLoading() {
        activityIndicator.stopAnimating()
    }
}

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath)
        if let repositoryCell = cell  as? RepositoryTableViewCell {
            repositoryCell.viewModel = viewModel?.item(for: indexPath.row)
            cell = repositoryCell
        }
        return cell
    }
}
