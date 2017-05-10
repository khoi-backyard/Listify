//
//  ListsViewController.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/25/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import Action

class ListsViewController: UIViewController, Bindable {

    var viewModel: ListsViewModel!
    let dataSource = RxTableViewSectionedAnimatedDataSource<ListsSection>()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutBtn: UIBarButtonItem!
    @IBOutlet weak var addBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
    }

    func bindViewModel() {
        viewModel.sectionItems
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx_disposeBag)

        tableView.rx.itemSelected.map { indexPath in
            try self.dataSource.model(at: indexPath) as! TaskList // swiftlint:disable:this force_cast
        }
        .subscribe(viewModel.selectListAction.inputs)
        .disposed(by: rx_disposeBag)

        logoutBtn.rx.action = viewModel.onLogOut
    }

    fileprivate func configureDataSource() {
        dataSource.configureCell = { dataSource, tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.taskListsCell.identifier,
                                                           for: indexPath) as? ListsTableViewCell else {
                fatalError("Expecting TaskListsTableViewCell")
            }
            cell.configure(with: item)
            return cell
        }
    }

}
