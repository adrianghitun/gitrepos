//
//  CoordinatedViewController.swift
//  GitHubRepos
//
//  Created by Adrian.Ghitun on 12/02/2021.
//  Copyright © 2021 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

/*
When the root view controller deinits, we should release the coordinator holding it.
*/
class CoordinatedViewController: UIViewController, ControllerDeinitReportable {
    weak var deinitDelegate: ControllerDeinitHandler?
    deinit {
        deinitDelegate?.didDeinit(controller: self)
    }
}
