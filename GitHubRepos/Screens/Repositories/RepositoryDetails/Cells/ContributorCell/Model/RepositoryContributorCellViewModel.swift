//
//  RepositoryContributorCellViewModel.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 12/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import Foundation

struct RepositoryContributorCellViewModel: TableCellViewModel {
    var contributor: RepositoryContributor
        
    init(contributor: RepositoryContributor) {
        self.contributor = contributor
    }
    
    var title: String {
        return contributor.login
    }
}
