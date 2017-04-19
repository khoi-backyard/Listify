//
//  AuthenticationViewController.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class AuthenticationViewController: UIViewController, Bindable {

  @IBOutlet weak var googleSignInBtn: UIButton!

    var viewModel: AuthenticationViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    func bindViewModel() {
        googleSignInBtn.rx.tap.bindTo(viewModel.googleLoginTap).addDisposableTo(rx_disposeBag)

        viewModel.loginResult.asObservable().subscribe(onNext: { (result) in
            print(result)
        }).addDisposableTo(rx_disposeBag)
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

extension AuthenticationViewController: GIDSignInUIDelegate {
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {

    }

    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        present(viewController, animated: true, completion: nil)
    }

    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        dismiss(animated: true, completion: nil)
    }
}
