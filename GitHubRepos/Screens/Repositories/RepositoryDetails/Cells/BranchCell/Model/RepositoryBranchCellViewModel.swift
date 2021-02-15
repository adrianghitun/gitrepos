//
//  RepositoryBranchCellViewModel.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 12/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import Foundation

struct RepositoryBranchCellViewModel: TableCellViewModel {
    var branch: RepositoryBranch
    
    init(branch: RepositoryBranch) {
        self.branch = branch
    }
    
    var title: String {
        return branch.name
    }
}
