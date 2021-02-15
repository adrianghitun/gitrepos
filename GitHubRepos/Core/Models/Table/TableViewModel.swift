//
//  TableViewModel.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 12/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import Foundation

enum DataState {
    case initialising, loading, loaded
}

protocol DataStateBindingProtocol {
    func dataStateDidChanged(_ state: DataState)
}

protocol TableViewViewModelProtocol {
    var dataSource: [TableSection] { get }

    var dataState: DataState { get }
    var dataStateBinding: DataStateBindingProtocol? { get set }
}

class TableViewViewModel: TableViewViewModelProtocol {
    var dataSource: [TableSection] = []
    
    var dataState: DataState = .initialising {
        didSet {
            dataStateBinding?.dataStateDidChanged(dataState)
        }
    }
    
    var dataStateBinding: DataStateBindingProtocol? {
        didSet {
            dataStateBinding?.dataStateDidChanged(dataState)
        }
    }
    
    init() {
        setupDataSource()
    }
    
    func setupDataSource() {
        dataSource = []
    }
    
    //MARK: DataSource
    var numberOfSections: Int {
        return dataSource.count
    }
    
    func title(at section: Int) -> String? {
        return dataSource[section].title
    }
    
    func numberOfItems(in sectionIndex: Int) -> Int {
        return dataSource[sectionIndex].cells.count
    }
    
    func item(at index: IndexPath) -> TableCellViewModel {
        return dataSource[index.section].cells[index.row]
    }
    
    func selectItem(at index: IndexPath) {}
}
