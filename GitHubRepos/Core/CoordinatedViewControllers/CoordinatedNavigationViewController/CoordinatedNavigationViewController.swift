//
//  CoordinatedNavigationViewController.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 12/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import UIKit

class CoordinatedNavigationViewController: UINavigationController, ControllerDeinitReportable {
    weak var deinitDelegate: ControllerDeinitHandler?
    deinit {
        deinitDelegate?.didDeinit(controller: self)
    }
}
