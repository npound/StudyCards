//
//  ViewController.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/6/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    
    //MARK: Properties

    @IBOutlet weak var bannerAd: GADBannerView!
    @IBOutlet weak var nametextfield: UITextField!
    @IBOutlet weak var libButton: UIButton!
    
    var indexcardDecks : [IndexCardDeck]?
    
    
    @IBAction func unwindtoMainMenu(_ sender: UIStoryboardSegue) {
        if let nc = sender.source as? iCardTableViewController
        {
    indexcardDecks = nc.indexcardDecks
    }
    }
    
    
    fileprivate func loadDecks() -> [IndexCardDeck]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: IndexCardDeck.ArchiveURL) as? [IndexCardDeck]
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "ToLib"  {
            let nc = segue.destination as! iCardTableViewController
            if(indexcardDecks != nil)
            {
            nc.indexcardDecks = indexcardDecks!
            }
            else
            {
                
                nc.indexcardDecks = [IndexCardDeck]()
            }
        }
        
        if segue.identifier == "ToQuiz"{
            let nc = segue.destination as! QuizTable
            if(indexcardDecks != nil)
            {
                nc.indexcardDecks = indexcardDecks!
            }
            else
            {
                
                nc.indexcardDecks = [IndexCardDeck]()
            }
            nc.navigationItem.title = "Choose deck"

            

        }
        
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(indexcardDecks == nil)
        {
        indexcardDecks = loadDecks()
        }
        
        
        bannerAd.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerAd.rootViewController = self
        bannerAd.load(GADRequest())
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "indexcard.png")
        backgroundImage.alpha = 0.3
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

