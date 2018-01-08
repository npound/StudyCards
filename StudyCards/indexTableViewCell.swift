//
//  indexTableView.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/8/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import UIKit

class indexTableViewCell: UITableViewCell {
    
    
 
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var CardKey: UILabel!
    var keyword :  String?
    var phrase: String?
    var cardID : Int?
    var created : Date?
    var changed : Date?
    
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
}

