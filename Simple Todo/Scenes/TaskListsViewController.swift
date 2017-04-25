//
//  TaskListsViewController.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/25/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import Action

class TaskListsViewController: UIViewController, Bindable {

    var viewModel: TaskListsViewModel!
    let dataSource = RxTableViewSectionedAnimatedDataSource<TaskListsSection>()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
    }

    func bindViewModel() {
        viewModel.sectionItems
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx_disposeBag)
    }

    fileprivate func configureDataSource() {
        dataSource.configureCell = { dataSource, tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.taskListsCell.identifier,
                                                           for: indexPath) as? TaskListsTableViewCell else {
                fatalError("Expecting TaskListsTableViewCell")
            }
            cell.configure(with: item)
            return cell
        }
    }

}
