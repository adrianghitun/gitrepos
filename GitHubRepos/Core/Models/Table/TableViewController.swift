//
//  TableViewController.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 12/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import UIKit

protocol TableViewController {
    var tableView: UITableView! { get set }
    var viewModel: TableViewViewModel? { get set }
    
    var cellMappings: [HashableType: UITableViewCell.Type] { get }
}

extension TableViewController where Self: UIViewController {
    func registerCells() {
        cellMappings.values.forEach {
            if let nibFile = $0.nibFile {
                let nib = UINib(nibName: nibFile, bundle: nibBundle)
                tableView.register(nib, forCellReuseIdentifier: $0.reuseIdentifier)
            } else {
                tableView.register($0, forCellReuseIdentifier: $0.reuseIdentifier)
            }
        }
    }
    
    func cell(for model: TableCellViewModel.Type) -> UITableViewCell.Type? {
        return cellMappings[model]
    }
}

// MARK: Private Extensions
private extension Dictionary {
    subscript(key: Any.Type) -> Value? where Key == HashableType {
        get { return self[HashableType(key)] }
        set { self[HashableType(key)] = newValue }
    }
}

struct HashableType : Hashable {
    static func == (lhs: HashableType, rhs: HashableType) -> Bool {
        return lhs.base == rhs.base
    }
    
    let base: Any.Type
    
    init(_ base: Any.Type) {
        self.base = base
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(base))
    }
}
