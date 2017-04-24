//
//  TaskItemTableViewCell.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/24/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit
import RxSwift

class TaskItemTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!

    var bag = DisposeBag()

    func configure(with task: Task) {
        task.rx.observe(String.self, "text").subscribe(onNext: { [weak self] in
            self?.taskLabel.text = $0
        })
        .addDisposableTo(bag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }

}
