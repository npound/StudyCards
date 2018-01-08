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
    @IBOutlet weak var quizCheck: UIImageView!
    var isOn = false
    var name : String?

    var deck : [IndexCard]?
    
    @objc private func Flip ()
    {
        isOn = !isOn
        quizCheck.isHidden = !quizCheck.isHidden
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        quizCheck.isHidden = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.Flip))
        self.addGestureRecognizer(tap)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
