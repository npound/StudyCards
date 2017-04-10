//
//  iCardTableViewCell.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/8/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import UIKit

class iCardTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    var deck : [IndexCard]?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
