//
//  ActivityIndicatorCell.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 12/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import UIKit

class ActivityIndicatorViewModel: TableCellViewModel {}

class ActivityIndicatorTableViewCell: TableCell {
    var activityIndicator = UIActivityIndicatorView.init(style: .gray)
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setupContent() {
        activityIndicator.startAnimating()
    }
}
