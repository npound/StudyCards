//
//  QuizDiffView.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/9/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import UIKit

class QuizDiffView: UIViewController {
    
    var name : String?
    var Deck : [IndexCard]?
    var master : [IndexCardDeck]?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let nc = segue.destination as! QuizView
        
if segue.identifier == "Easy"
{
    nc.diff = 1
        }
        if segue.identifier == "Med"
        {
            nc.diff = 2
        }
        if segue.identifier == "Hard"
        {
            nc.diff = 3
        }
        
        nc.deck = Deck
        nc.name = name
        nc.master = master
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
