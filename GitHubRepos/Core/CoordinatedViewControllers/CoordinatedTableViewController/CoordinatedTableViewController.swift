//
//  CoordinatedTableViewController.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 12/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

class CoordinatedTableViewController: CoordinatedViewController, TableViewController, DataStateBindingProtocol {
    var cellMappings: [HashableType : UITableViewCell.Type] { [:] }
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            registerCells()
        }
    }
    
    var viewModel: TableViewViewModel? {
        didSet {
            viewModel?.dataStateBinding = self
        }
    }
    
    func dataStateDidChanged(_ state: DataState) {
        switch state {
        case .initialising:
            do {
                // nothing to do
            }
        case .loading:
            do {
                tableView?.reloadData()
            }
        case .loaded:
            do {
                tableView?.reloadData()
            }
        }
    }
}

//MARK: DataSource
extension CoordinatedTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.title(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = viewModel?.item(at: indexPath),
           let cellType = cell(for: type(of: item)),
           let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier),
           let mvvmCell = cell as? TableCell {
            mvvmCell.viewModel = item
            return cell
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems(in: section) ?? 0
    }
}

//MARK: Delegate
extension CoordinatedTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectItem(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
