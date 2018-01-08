//
//  NewCardController.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/8/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import GoogleMobileAds
import UIKit

class NewCardController: UIViewController,UITextFieldDelegate,UITextViewDelegate {


    @IBOutlet weak var keywordInput: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var phraseInput: UITextView!
    @IBOutlet weak var bannerAd: GADBannerView!
    
    var newcard: IndexCard?
    var master: [IndexCardDeck]?
    var id = 0
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        if let savebutton = sender as? UIBarButtonItem
        {
        if savebutton == saveButton
        {
        let cardName = keywordInput.text
        let phraseName = phraseInput.text
            
            
            
            newcard = IndexCard(keyword: cardName!, phrase: phraseName!,created: NSDate.init(timeIntervalSinceNow: 0), changed: NSDate.init(timeIntervalSinceNow: 0))
        master![id].changed = NSDate.init(timeIntervalSinceNow: 0)
        master![id].deck.append(newcard!)
        SaveDeck()
        }
    }
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
    
    
    
    
    @IBAction func KeywordEditingChanged(_ sender: AnyObject) {
        updateSaveButtonState()
        navigationItem.title = keywordInput.text
    }
 
    func textViewDidChange(_ textView: UITextView)
    {
        updateSaveButtonState()

    }
    
    
    
    
    
    fileprivate func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = keywordInput.text
        let text2 = phraseInput.text
        
        if(text != nil && text2 != nil){
            saveButton.isEnabled = (!text!.isEmpty && !text2!.isEmpty)}
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            dismissKeyboard()
            return false
        }
        return true
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keywordInput.delegate = self
        phraseInput.delegate = self
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "indexcard.png")
        backgroundImage.alpha = 0.3
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        bannerAd.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerAd.rootViewController = self
        bannerAd.load(GADRequest())
        
        
        phraseInput.layer.borderWidth = 0.25
        phraseInput.layer.borderColor = UIColor.black.cgColor
        
        keywordInput.layer.borderWidth = 0.25
        keywordInput.layer.borderColor = UIColor.black.cgColor
        
        updateSaveButtonState()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
