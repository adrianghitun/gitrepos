//
//  UIWindow+Utils.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 22/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    func changeRootAnimated(newRootVC: UIViewController, animationDuration: TimeInterval = Constants.Animations.defaultAnimationDuration) {
        guard let snapshot = snapshotView(afterScreenUpdates: true) else {
            rootViewController = newRootVC
            return
        }

        newRootVC.view.addSubview(snapshot)
        rootViewController = newRootVC
        UIView.animate(withDuration: animationDuration, animations: {
            snapshot.layer.opacity = 0
        }, completion: { (_) in
            snapshot.removeFromSuperview()
        })
    }
}
