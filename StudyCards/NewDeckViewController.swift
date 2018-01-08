//
//  NewDeck.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/8/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import GoogleMobileAds
import UIKit
import os

class NewDeckViewController: UIViewController,UITextFieldDelegate {

        
        //MARK: Properties

    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var bannerAd: GADBannerView!
    
    var newdeck: IndexCardDeck?
    
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
            let deckName = inputText.text
        newdeck = IndexCardDeck(deck: [IndexCard](),name: deckName!, created: NSDate.init(timeIntervalSinceNow: 0), changed: NSDate.init(timeIntervalSinceNow: 0))
    }
    

    @IBAction func EditingChanged(_ sender: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
        
        updateSaveButtonState()
        navigationItem.title = inputText.text
    }
    
     @IBAction func cancel(_ sender: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
    
    

    
    fileprivate func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = inputText.text
        saveButton.isEnabled = !text!.isEmpty
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            inputText.delegate = self
            
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = #imageLiteral(resourceName: "indexcard.png")
            backgroundImage.alpha = 0.3
            backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0)
            
            inputText.layer.borderWidth = 0.25
            inputText.layer.borderColor = UIColor.black.cgColor
            
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            view.addGestureRecognizer(tap)
            
            
            bannerAd.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            bannerAd.rootViewController = self
            bannerAd.load(GADRequest())
            
            updateSaveButtonState()
            // Do any additional setup after loading the view, typically from a nib.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
    
}
