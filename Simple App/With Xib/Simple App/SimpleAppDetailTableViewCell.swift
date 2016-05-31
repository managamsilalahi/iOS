//
//  SimpleAppDetailTableViewCell.swift
//  Simple App
//
//  Created by Admin on 5/25/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class SimpleAppDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
