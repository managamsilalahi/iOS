//
//  SimpleAppTableViewCell.swift
//  Simple App
//
//  Created by Admin on 5/23/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class SimpleAppTableViewCell: UITableViewCell {
    
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
