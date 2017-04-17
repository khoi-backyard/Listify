//
//  TextFieldTableViewCell.swift
//  Simple Todo
//
//  Created by Khoi Lai on 3/29/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var inputLabel: UILabel!

    @IBOutlet weak var inputTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
