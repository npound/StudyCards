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
        
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
            guard let ncViewController = segue.destination as? QuizDiffView else {
                fatalError("Conversion to Controller failed")}
        let senderCell = sender as! QuizCell
        
        ncViewController.master = indexcardDecks
        ncViewController.Deck = senderCell.deck!
        ncViewController.name = senderCell.quiznameLabel.text
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
            
            cell?.quiznameLabel.text = indexcarddeck.name
            cell?.deck = indexcarddeck.deck
            
            
            
            
            return cell!
        }
        
        
        
}
