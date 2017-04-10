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

    
    
    
  /*
    private func LoadSampeCards(){
        
        var deck1 = [IndexCard]()
        let card1 = IndexCard(keyword: "test keyword 1",phrase: "test phrase1")
        deck1.append(card1);
        let TestDeck1 = IndexCardDeck(deck: deck1,name: "Test Deck 1")
        let TestDeck2 = IndexCardDeck(deck: deck1,name: "Test Deck 2")
        
        indexcardDecks += [TestDeck1, TestDeck2];
        
        
        
    }
   */
    
    @IBAction func unwindToDeckListCancel(_ sender: UIStoryboardSegue) {}
    @IBAction func unwindToDeckList(_ sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as?  NewDeckViewController{
            let Newdeck = sourceViewController.newdeck as IndexCardDeck!
            
            let newIndexPath = IndexPath(item: indexcardDecks.count, section: 0)
            indexcardDecks.append(Newdeck!)
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
