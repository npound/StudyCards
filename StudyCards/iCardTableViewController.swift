//
//  iCardTableViewController.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/8/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import UIKit
import os;

class iCardTableViewController: UITableViewController {
    
     var indexcardDecks = [IndexCardDeck]()
    var lib = true

    
    @IBAction func unwindToDeckListCancel(_ sender: UIStoryboardSegue) {}
    @IBAction func unwindToDeckList(_ sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as?  NewDeckViewController{
            let Newdeck = sourceViewController.newdeck as IndexCardDeck!
            
            let newIndexPath = IndexPath(item: indexcardDecks.count, section: 0)
            indexcardDecks.append(Newdeck!)
            if indexcardDecks.count > 1{ sortButton.isEnabled = true}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            SaveDeck()
        }
    }
    @IBAction func unwindwithMaster(_ sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as?  indexTableViewController{
            let deck = sourceViewController.master as [IndexCardDeck]!
                    indexcardDecks = deck!
            tableView.reloadData()
        }
    }
    
    

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
 
        if segue.identifier == "ShowCards"{
            guard let ncViewController = segue.destination as? indexTableViewController else {
             fatalError("Conversion to Controller failed")
            }
        
            guard let senderCell = sender as? iCardTableViewCell else {
                fatalError("Conversion to cell failed")
            }
            
            ncViewController.indexCards = senderCell.deck!
            ncViewController.navigationItem.title = senderCell.nameLabel.text!
            ncViewController.master = indexcardDecks
        }
        }
    
    fileprivate func SaveDeck()
    {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(indexcardDecks, toFile: IndexCardDeck.ArchiveURL)
        print(IndexCardDeck.ArchiveURL)
        
        if isSuccessfulSave {
            print("deck successfully saved.")
        } else {
            print("Failed to deck meals...")
        }
    }
    
        @IBOutlet var UIDeckTableView: UITableView!
    
    override func tableView( _ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Inserting new item to the table
            UIDeckTableView.beginUpdates()
            indexcardDecks.remove(at: indexPath.row)
            UIDeckTableView.deleteRows(at: [indexPath], with: .automatic)
            UIDeckTableView.endUpdates()
            
            SaveDeck()
        }
    }
    
    
    
    @IBOutlet weak var sortButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        filterLabel.text = "Sort: High to Low"
        if(indexcardDecks.count > 1){SortAZHigh()}
        else{ sortButton.isEnabled = false}
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

    
    
    
    
    private func SortLastChanged()
    {
        for i in 0...indexcardDecks.count-2
        {
            for j in (i+1)...indexcardDecks.count-1
            {

             if !(indexcardDecks[i].changed?.isGreaterThanDate(dateToCompare: indexcardDecks[j].changed!))!
             {
                let temp = indexcardDecks[i]
                indexcardDecks[i] = indexcardDecks[j]
                indexcardDecks[j] = temp
                }
                
            }
        }
        tableView.reloadData()
    }
    
    private func SortLastCreated()
    {
        for i in 0...indexcardDecks.count-2
        {
            for j in (i+1)...indexcardDecks.count-1
            {
    
                if !(indexcardDecks[i].created?.isGreaterThanDate(dateToCompare: indexcardDecks[j].created!))!
                {
                    let temp = indexcardDecks[i]
                    indexcardDecks[i] = indexcardDecks[j]
                    indexcardDecks[j] = temp
                }
                
            }
        }
        tableView.reloadData()
    }
    
    
    private func SortAZHigh()
    {
        for i in 0...indexcardDecks.count-2
        {
            for j in (i+1)...indexcardDecks.count-1
            {
                if (!indexcardDecks[i].name.isGreater(stringCompared: indexcardDecks[j].name))
                {
                    let temp = indexcardDecks[i]
                    indexcardDecks[i] = indexcardDecks[j]
                    indexcardDecks[j] = temp
                }
                
            }
        }
        tableView.reloadData()
    }
    
    private func SortAZLow()
    {
        for i in 0...indexcardDecks.count-2
        {
            for j in (i+1)...indexcardDecks.count-1
            {
                if (indexcardDecks[i].name.isGreater(stringCompared: indexcardDecks[j].name))
                {
                    let temp = indexcardDecks[i]
                    indexcardDecks[i] = indexcardDecks[j]
                    indexcardDecks[j] = temp
                }
                
            }
        }
        tableView.reloadData()
    }
    
    @IBOutlet weak var filterLabel: UILabel!
    
    
    @IBAction func filterClick(_ sender: UIButton) {
        if(filterLabel.text! == "Sort: High to Low")
        {
            filterLabel.text = "Sort: Low to High"
            SortAZLow()
        }
        
        else if(filterLabel.text! == "Sort: Low to High")
        {
            filterLabel.text = "Sort: Last Changed"
            SortLastChanged()
        }

        else if(filterLabel.text! == "Sort: Last Changed")
        {
            filterLabel.text = "Sort: Last Created"
            SortLastCreated()
        }

        else if(filterLabel.text! == "Sort: Last Created")
        {
            filterLabel.text = "Sort: High to Low"
            SortAZHigh()
        }
    }
    
    
    
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return indexcardDecks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "iCardTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)as? iCardTableViewCell
        
        
        // Configure the cell...

        let indexcarddeck = indexcardDecks[indexPath.row]
        
        cell?.nameLabel.text = indexcarddeck.name
        cell?.deck = indexcarddeck.deck
        
        
        
        return cell!
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
