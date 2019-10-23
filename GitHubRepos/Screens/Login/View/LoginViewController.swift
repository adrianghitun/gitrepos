//
//  ViewController.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 22/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import UIKit

class LoginViewController: CoordinatedViewController {
    @IBOutlet weak var loginButton: UIButton!

    var viewModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        loginButton.setTitle(viewModel?.loginButtonTitle, for: .normal)
    }

    @IBAction func login(_ sender: Any) {
        viewModel?.didPressLoginButton()
    }
}

