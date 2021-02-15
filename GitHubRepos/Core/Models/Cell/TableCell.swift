//
//  TableCell.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 12/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import Foundation

protocol TableCellViewModel {
    var title: String { get }
    var content: String { get }
}

extension TableCellViewModel {
    var title: String { "" }
    var content: String { "" }
}

//MARK: Concrete Type
import UIKit
class TableCell: UITableViewCell {
    var viewModel: TableCellViewModel? {
        didSet {
            setupContent()
        }
    }
    
    func setupContent() {
        // Provide own implementation in extension
    }
}

// MARK: Utils Extensions
extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
    
    @objc class var nibFile: String? {
        // Provide own nib name in extension
        nil
    }
}
