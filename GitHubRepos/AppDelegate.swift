//
//  AppDelegate.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 22/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appFlowCoordinator: AppFlowCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)

        appFlowCoordinator = AppFlowCoordinator(with: window)
        appFlowCoordinator?.start()

        window.makeKeyAndVisible()
        self.window = window

        return true
    }

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        appFlowCoordinator?.handle(url: url)
        return true
    }


}
