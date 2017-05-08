//
//  TaskItemTableViewCell.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/24/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit
import RxSwift
import Action

class TaskItemTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var toggleBtn: UIButton!

    var bag = DisposeBag()

    func configure(with task: Task, action: CocoaAction) {

        toggleBtn.rx.action = action

        task.rx.observe(String.self, "text").subscribe(onNext: { [weak self] in
            self?.taskLabel.text = $0
        })
        .addDisposableTo(bag)

        task.rx.observe(Date.self, "completedDate").subscribe(onNext: { [weak self] (completed) in
            let image = completed == nil ? R.image.checkmarkUnchecked() : R.image.checkmarkChecked()
            self?.toggleBtn.setImage(image, for: .normal)
        })
        .addDisposableTo(bag)
    }

    override func prepareForReuse() {
        toggleBtn.rx.action = nil
        bag = DisposeBag()
        super.prepareForReuse()
    }

}
