//
//  IndexCardViewController.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/8/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import UIKit

class IndexCardViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    //MARK: Properties

    var keyword :String?
    var phrase : String?
    var oldkey : String?
    var oldphrase :String?
    var haschanged = false
    var master : [IndexCardDeck]?
    var id = 0
    
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var keywordText: UITextField!
    @IBOutlet weak var phraseText: UITextView!
    
    
    

    
    

    
    func textViewDidChange(_ sender: UITextView)
    {
        SaveButton.isHidden = false
        CancelButton.isHidden = false
    }
    @IBAction func KeyEditingChanged(_ sender: UITextField) {
        
        SaveButton.isHidden = false
        CancelButton.isHidden = false
    }
    
    @IBAction func onSave(_ sender: UIButton) {
        if keywordText.isHidden
        {
            phrase = phraseText.text
            haschanged = true
        }
        else
        {
            keyword =  keywordText.text
            haschanged = true
        }
        
        SaveButton.isHidden = true
        CancelButton.isHidden = true
        
        for i in 0...master![id].deck.count-1
        {
if master![id].deck[i].keyword == oldkey && master![id].deck[i].phrase == oldphrase
{
                master![id].deck[i].phrase = self.phrase
                master![id].deck[i].keyword = self.keyword
            }
        }
        SaveDeck()
        
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
    
    
    
    
    @IBAction func onCancel(_ sender: AnyObject) {
        phrase = phraseText.text
        
        SaveButton.isHidden = true
        CancelButton.isHidden = true
    }
    
    @IBAction func Flip(_ sender: UIBarButtonItem) {
        phraseText.isHidden = !phraseText.isHidden
        keywordText.isHidden = !keywordText.isHidden
        SaveButton.isHidden = true
        CancelButton.isHidden = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        phraseText!.delegate = self
        keywordText.delegate = self
        
        keywordText.text = keyword
        phraseText.text = phrase
        oldkey = keyword
        oldphrase = phrase
        phraseText.isHidden = true
        
        SaveButton.isHidden = true
        CancelButton.isHidden = true
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

