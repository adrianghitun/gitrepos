//
//  RepositoryBranchCell.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 12/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import UIKit

class RepositoryBranchCell: TableCell {
    var branchCellViewModel: RepositoryBranchCellViewModel? {
        return viewModel as? RepositoryBranchCellViewModel
    }
    
    override func setupContent() {
        textLabel?.text = viewModel?.title
        imageView?.image = UIImage(systemName: "arrow.triangle.branch")
    }
}
