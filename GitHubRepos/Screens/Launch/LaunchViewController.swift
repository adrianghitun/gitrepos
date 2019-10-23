//
//  LaunchViewController.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

class LaunchViewController: CoordinatedViewController {
    var topView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let launchingVC = Storyboard.launch.initialViewController, let launchView = launchingVC.view {
            view.addSubview(launchView)
            launchView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0).isActive = true
            launchView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0).isActive = true
            launchView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0).isActive = true
            launchView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 0).isActive = true

            topView = launchView.subviews.first
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        /*
         Light animation for a better transition from Launch screen to the actual application
         */
        if let view = topView {
            view.heightAnchor.constraint(equalToConstant: 0).isActive = true
            UIView.animate(withDuration: Constants.Animations.defaultAnimationDuration) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
}
