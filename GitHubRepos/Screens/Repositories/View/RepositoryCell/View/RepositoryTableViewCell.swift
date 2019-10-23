//
//  RepositoryTableViewCell.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var viewModel: RepositoryCellViewModel? {
        didSet {
            setupView()
        }
    }

    func setupView() {
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description

        viewModel?.image(completion: { [weak self] (image) in
            if let image = image as? UIImage {
                self?.profileImageview.image = image
            }
        })
    }
}


