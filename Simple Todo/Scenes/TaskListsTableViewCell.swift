//
//  TaskListsTableViewCell.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/25/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit
import RxSwift

class TaskListsTableViewCell: UITableViewCell {
    @IBOutlet weak var listNameLabel: UILabel!

    var bag = DisposeBag()

    func configure(with taskList: TaskList) {
        taskList.rx.observe(String.self, "name").subscribe(onNext: { [weak self] name in
            self?.listNameLabel.text = name
        })
        .disposed(by: bag)
    }

    override func prepareForReuse() {
        bag = DisposeBag()
        super.prepareForReuse()
    }
}
