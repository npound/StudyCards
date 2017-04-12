
import UIKit

class indexTableViewController: UITableViewController {
    
    var indexCards = [IndexCard]()
    var master: [IndexCardDeck]?
    var path : IndexPath?
    var id = 0

    
    
    
    @IBAction func unwindToCardListCancel(_ sender: UIStoryboardSegue) {}
    @IBAction func unwindToCardList(_ sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as?  NewCardController{
            let Newcard = sourceViewController.newcard as IndexCard!
            
            let newIndexPath = IndexPath(item: indexCards.count, section: 0)
            indexCards.append(Newcard!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    @IBAction func unwindwithCardChanged(_ sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as?  IndexCardViewController{
            if sourceViewController.haschanged == true
            {
                for i in 0...indexCards.count-1{
                    if(sourceViewController.oldkey == indexCards[i].keyword && sourceViewController.oldphrase == indexCards[i].phrase)
                    {
                        indexCards[i].phrase = sourceViewController.phrase!
                        indexCards[i].keyword = sourceViewController.keyword!
    
                    }
                    master = sourceViewController.master
                }
                
                
             tableView.reloadRows(at: [path!], with: .automatic)
            }

        }
    }
    
    @IBOutlet var UITableViewLink: UITableView!

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "ShowCard"{
            guard let ncViewController = segue.destination as? IndexCardViewController else {
                fatalError("Conversion to Controller failed")
            }
            
            guard let senderCell = sender as? indexTableViewCell else {
                fatalError("Conversion to cell failed")
            }
            
            let selectedcell = sender as! indexTableViewCell
            path = tableView.indexPath(for: selectedcell)
            
            let sendCell = sender as! indexTableViewCell
            
            
            ncViewController.keyword = senderCell.keyword!
            ncViewController.phrase = senderCell.phrase!
            ncViewController.master = master
            ncViewController.id = id
            ncViewController.cardID = sendCell.cardID!
            ncViewController.count = indexCards.count
        }
        
        else if segue.identifier == "NewCard"{
            guard let ncViewController = segue.destination as? NewCardController else {
                fatalError("Conversion to cell failed")
            }
            ncViewController.master = master
            ncViewController.id = id
            
        }
    }
    
    
    fileprivate func GetID ()
    {
        if master?.count != 0
        {
        for i in 0...master!.count-1
        {
            if master![i].name == navigationItem.title
            {id = i}
        }
        }
    }
    
    

    
    override func tableView( _ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Inserting new item to the table
            UITableViewLink.beginUpdates()
            indexCards.remove(at: indexPath.row)
            master![id].deck.remove(at: indexPath.row)
            UITableViewLink.deleteRows(at: [indexPath], with: .automatic)
            UITableViewLink.endUpdates()
            
            SaveDeck()
        }
    }
    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITableViewLink.delegate = self
        GetID()
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
        return indexCards.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "IndexCardCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)as? indexTableViewCell
        
        
        // Configure the cell...
        
        let indexcard = indexCards[indexPath.row]
        
        cell!.CardKey.text = indexcard.keyword
        cell!.keyword = indexcard.keyword
        cell!.phrase = indexcard.phrase
        cell!.cardID = indexPath.row
        
        return cell!
    }
    
    
    
    
    fileprivate func SaveDeck()
    {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(master!, toFile: IndexCardDeck.ArchiveURL)
        print(IndexCardDeck.ArchiveURL)
        
        if isSuccessfulSave {
            print("deck successfully saved.")
        } else {
            print("Failed to deck meals...")
        }
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
