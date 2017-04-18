//
//  AuthenticationViewController.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
