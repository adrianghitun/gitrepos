//
//  RepositoryDetailsViewController.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 10/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

class RepositoryDetailsViewController: CoordinatedTableViewController {
    override var cellMappings: [HashableType : UITableViewCell.Type] {
        [HashableType(RepositoryCellViewModel.self): RepositoryCell.self,
         HashableType(ActivityIndicatorViewModel.self): ActivityIndicatorTableViewCell.self,
         HashableType(RepositoryBranchCellViewModel.self): RepositoryBranchCell.self,
         HashableType(RepositoryContributorCellViewModel.self): RepositoryContributorCell.self]
    }
}
