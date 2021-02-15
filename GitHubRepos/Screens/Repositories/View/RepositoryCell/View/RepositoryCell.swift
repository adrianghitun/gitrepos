//
//  RepositoryTableViewCell.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

class RepositoryCell: TableCell {
    class override var nibFile: String? {
        return reuseIdentifier
    }
    
    @IBOutlet weak var profileImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var repositoryViewModel: RepositoryCellViewModel? {
        viewModel as? RepositoryCellViewModel
    }
    
    override func setupContent() {
        titleLabel.text = repositoryViewModel?.title
        descriptionLabel.text = repositoryViewModel?.description

        repositoryViewModel?.image(completion: { [weak self] (image) in
            if let image = image as? UIImage {
                self?.profileImageview.image = image
            }
        })
    }
}


