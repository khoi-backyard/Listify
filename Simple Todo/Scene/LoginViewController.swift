//
//  LoginViewController.swift
//  Simple Todo
//
//  Created by Khoi Lai on 3/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    let loginLabel = UILabel().then {
        $0.text = "Login Screen"
    }

    let usernameTextField = UITextField().then {
        $0.placeholder = "Enter email"
    }

    let passwordTextField = UITextField().then {
        $0.placeholder = "Enter password"
    }

    let loginBtn = UIButton().then {
        $0.setTitle("Login", for: .normal)
        $0.setTitle("Login disabled", for: .disabled)
        $0.backgroundColor = UIColor.blue
    }

    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        stackView.addArrangedSubview(loginLabel)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginBtn)

        view.addSubview(stackView)

        _setupConstraints()
    }

    private func _setupConstraints() {
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
