//
//  TasksViewController.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/24/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import Action

class TasksViewController: UIViewController, Bindable {

    var viewModel: TasksViewModel!
    let dataSource = RxTableViewSectionedAnimatedDataSource<TaskSection>()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60

        configureDataSource()
    }

    func bindViewModel() {
        viewModel.sectionedItems
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
    }

    fileprivate func configureDataSource() {
        dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].model
        }

        dataSource.configureCell = { [weak self] dataSource, tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.taskCell.identifier,
                                                           for: indexPath) as? TaskItemTableViewCell else {
                fatalError("Expecting TaskItemTableViewCell")
            }
            cell.configure(with: item)
            return cell
        }
    }
}
