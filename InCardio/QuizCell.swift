//
//  QuizCell.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/9/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import UIKit

class QuizCell: indexTableViewCell {
    


    @IBOutlet weak var quiznameLabel: UILabel!

    

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
