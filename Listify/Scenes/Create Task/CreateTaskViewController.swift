//
//  CreateTaskViewController.swift
//  Listify
//
//  Created by Khoi Lai on 5/27/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import Action

class CreateTaskViewController: UIViewController, Bindable {

    var viewModel: CreateTaskViewModel!

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var addTaskBtn: UIButton!
    @IBOutlet weak var defaultActionsTableView: UITableView!
    @IBOutlet weak var taskTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bindViewModel() {
        cancelBtn.rx.action = viewModel.onDismissed()

        let actions = viewModel.onCreateTask

        addTaskBtn.rx.tap
            .withLatestFrom(taskTextField.rx.text.orEmpty)
            .bind(to: actions.inputs)
            .disposed(by: rx_disposeBag)
    }
}
