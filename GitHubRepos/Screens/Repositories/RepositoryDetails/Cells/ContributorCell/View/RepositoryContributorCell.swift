//
//  RepositoryContributorCell.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 12/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import UIKit

class RepositoryContributorCell: TableCell {
    var contributorCellViewModel: RepositoryContributorCellViewModel? {
        return viewModel as? RepositoryContributorCellViewModel
    }
    
    override func setupContent() {
        textLabel?.text = viewModel?.title
        imageView?.image = UIImage(systemName: "person")
    }
}
