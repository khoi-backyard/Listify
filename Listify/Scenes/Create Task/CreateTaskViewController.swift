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
    @IBOutlet weak var ttsBtn: UIButton!

    @IBOutlet weak var defaultActionsTableView: UITableView!
    @IBOutlet weak var taskTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bindViewModel() {
        cancelBtn.rx.action = viewModel.onDismissed()

        let onCreateTaskAction = viewModel.onCreateTask
        let onTaskTitleChanged = viewModel.onTaskTitleChanged

        taskTextField.rx.text.orEmpty
            .bind(to: onTaskTitleChanged.inputs)
            .disposed(by: rx_disposeBag)

        addTaskBtn.rx.tap
            .withLatestFrom(taskTextField.rx.text.orEmpty)
            .bind(to: onCreateTaskAction.inputs)
            .disposed(by: rx_disposeBag)

        let enabledCreateButton = onTaskTitleChanged
            .elements
            .startWith(false)
            .share()

        enabledCreateButton
            .map { !$0 }
            .bind(to: addTaskBtn.rx.isHidden)
            .disposed(by: rx_disposeBag)

        enabledCreateButton
            .bind(to: ttsBtn.rx.isHidden)
            .disposed(by: rx_disposeBag)
    }

}
