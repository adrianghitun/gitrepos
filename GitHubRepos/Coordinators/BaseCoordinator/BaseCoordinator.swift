//
//  BaseCoordinator.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 22/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Flow Coordinator Protocols

/*
 A retain mechanism should be in place, otherwise coordinators will be released imediately after init
 Every flow coordinator should know about his child coordinators and monitor their status.
 When a child coordinator reports as being deinitialized, we release it
 */
protocol FlowCoordinator: class {
    var childCoordinators: [FlowCoordinator] {get set}
    func startChild(coordinator: StartableFlowCoordinator)
}

protocol StartableFlowCoordinator: CoordinatorReleaseReporter {
    func start()
}

protocol CoordinatorReleaseReporter: FlowCoordinator {
    var releaseDelegate: CoordinatorReleaseHandler? {get set}
}

protocol CoordinatorReleaseHandler: class {
    func release(coordinator: FlowCoordinator)
}

// MARK: BaseCoordinator

/*
 Every coordinator should be both a reporter (letting the parent coordinator know it should be released) and a handler (releasing it's childs when they report as needing to be released)
 */
class BaseFlowCoordinator: FlowCoordinator, CoordinatorReleaseReporter, CoordinatorReleaseHandler {
    weak var releaseDelegate: CoordinatorReleaseHandler?
    var childCoordinators: [FlowCoordinator] = []

    func startChild(coordinator: StartableFlowCoordinator) {
        childCoordinators.append(coordinator)
        coordinator.releaseDelegate = self
        coordinator.start()
    }

    func release(coordinator: FlowCoordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}

// MARK: Primary Coordinators

class WindowFlowCoordinator: BaseFlowCoordinator, ControllerDeinitHandler {
    var window: UIWindow

    init(with window: UIWindow) {
        self.window = window
    }

    func start(with controller: ControllerDeinitReportable) {
        controller.deinitDelegate = self

        if window.rootViewController != nil {
            window.changeRootAnimated(newRootVC: controller)
        } else {
            window.rootViewController = controller
        }
    }

    func didDeinit(controller: ControllerDeinitReportable) {
        releaseDelegate?.release(coordinator: self)
    }
}

class NavigationFlowCoordinator: BaseFlowCoordinator, ControllerDeinitHandler {
    var navigationController: UINavigationController

    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(with controller: CoordinatedViewController) {
        controller.deinitDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }

    func didDeinit(controller: ControllerDeinitReportable) {
        releaseDelegate?.release(coordinator: self)
    }
}

// MARK: - View Controller Protocol

/*
 In order to know when a coordinator should be released, we watch the status of it's root view controller
 */
protocol ControllerDeinitHandler: class {
    func didDeinit(controller: ControllerDeinitReportable)
}

protocol ControllerDeinitReportable: UIViewController {
    var deinitDelegate: ControllerDeinitHandler? {get set}
}
