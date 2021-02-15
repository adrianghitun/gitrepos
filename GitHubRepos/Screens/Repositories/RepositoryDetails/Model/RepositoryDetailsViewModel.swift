//
//  RepositoryDetailsViewModel.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 10/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import Foundation

class RepositoryDetailsViewModel: TableViewViewModel {
    let service: RepositoryDetailsServiceProtocol
    let imageProvider: RepositoryImageProviderProtocol
    
    var repository: Repository
    
    init(service: RepositoryDetailsServiceProtocol,
         imageProvider: RepositoryImageProviderProtocol,
         repository: Repository) {
        self.service = service
        self.imageProvider = imageProvider
        self.repository = repository
        super.init()
        loadData()
    }

    override func setupDataSource() {
        let repositoryCell = RepositoryCellViewModel(with: repository)
        repositoryCell.imageProvider = imageProvider
        
        dataSource = [TableSection(title: "Repo Description", cells: [repositoryCell]),
                      TableSection(title: "Branches", cells: [ActivityIndicatorViewModel()]),
                      TableSection(title: "Contributors", cells: [ActivityIndicatorViewModel()])]
    }
    
    //MARK: Data load
    func loadData() {
        dataState = .loading
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            group.leave()
        }
        
        group.enter()
        service.branches(for: repository) { [weak self] (branches) in
            self?.branchesSection.cells = branches.map({ RepositoryBranchCellViewModel(branch: $0) })
            group.leave()
        }
        
        group.enter()
        service.contributors(for: repository) { [weak self] (contributors) in
            self?.contributorsSection.cells = contributors.map({ RepositoryContributorCellViewModel(contributor: $0) })
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.dataState = .loaded
        }
    }
}

//MARK: DataSource
private extension RepositoryDetailsViewModel {
    var descriptionSection: TableSection {
        return dataSource[0]
    }
    
    var branchesSection: TableSection {
        return dataSource[1]
    }
    
    var contributorsSection: TableSection {
        return dataSource[2]
    }
}
