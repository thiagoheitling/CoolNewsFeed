//
//  CustomTableViewCell.swift
//  CoolNewsFeed
//
//  Created by Thiago Heitling on 2016-02-16.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    // MARK : properties
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
