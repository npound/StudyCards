//
//  QuizTable.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/9/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import UIKit

class QuizTable: UITableViewController {

    
        var indexcardDecks = [IndexCardDeck]()
    var gamedeck = [IndexCard]()
    var quizName = "Mixed Quiz"
        
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
     if segue.identifier == "ToDiff"
     {
            guard let ncViewController = segue.destination as? QuizDiffView else {
                fatalError("Conversion to Controller failed")}
        
        GetCheckedCells(all: false)
        
        ncViewController.master = indexcardDecks
        ncViewController.Deck = gamedeck
        ncViewController.name = quizName
        }
        
        
        
        else if segue.identifier == "ToGame"
     {
        
        guard let nc = segue.destination as? QuizView else {
            fatalError("Conversion to Controller failed")}
        
        GetCheckedCells(all: true)
        
        nc.diff = 2
        nc.deck = gamedeck
        nc.name = quizName
        nc.master = indexcardDecks
        
        }
    }

    
    
    func GetCheckedCells(all : Bool)
    {
        var cells = tableView.visibleCells as! [QuizCell]
        var notOne = false
        if cells.count != 0
        {
        for i in 0...cells.count-1
        {
            if all == false {
            if cells[i].isOn == true
            {
            gamedeck += cells[i].deck!
    
                if (notOne == false)
                {quizName = cells[i].name!
                    notOne = true}
            }
            }
            
            else
            {
                 gamedeck += cells[i].deck!
                quizName = "Quiz All"
            }
            
        }
    }
    }
    
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //LoadSampeCards()
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return indexcardDecks.count
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cellIdentifier = "QuizCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)as? QuizCell
            
            
            // Configure the cell...
            
            let indexcarddeck = indexcardDecks[indexPath.row]
            
            
            cell?.name = indexcarddeck.name
            cell?.quiznameLabel.text = indexcarddeck.name
            cell?.deck = indexcarddeck.deck
            
            
            
            
            return cell!
        }
        
        
        
}
