//
//  IndexCardViewController.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/8/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import UIKit
import GoogleMobileAds

class IndexCardViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    //MARK: Properties

    var keyword :String?
    var phrase : String?
    var oldkey : String?
    var oldphrase :String?
    var haschanged = false
    var master : [IndexCardDeck]?
    var id = 0
    var cardID = 0
    var count = 0
    
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var keywordText: UITextField!
    @IBOutlet weak var phraseText: UITextView!
    
    @IBOutlet weak var bannerAd: GADBannerView!
    
    


    
    

    @IBAction func TextFieldEditingChanged(_ sender: Any) {
        SaveButton.isHidden = false
        CancelButton.isHidden = false
    }
    
    func textViewDidChange(_ sender: UITextView)
    {
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
    master![id].deck[i].changed = NSDate.init(timeIntervalSinceNow: 0)
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
        DoaFlip()
    }
    
    private func DoaFlip()
    {
        phraseText.isHidden = !phraseText.isHidden
        keywordText.isHidden = !keywordText.isHidden
        SaveButton.isHidden = true
        CancelButton.isHidden = true
        
    }
    
    func SwipeUp(){
        
        cardID += 1
        if cardID >= count
        {
        cardID = 0
        }
        
        phrase = master?[id].deck[cardID].phrase
        keyword = master?[id].deck[cardID].keyword
        initView()
    }
    
    func SwipeDown(){
        
        cardID -= 1
        if cardID <= -1
        {
            cardID = count - 1
        }
        
        phrase = master?[id].deck[cardID].phrase
        keyword = master?[id].deck[cardID].keyword
        initView()
    }
    
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                DoaFlip()
            case UISwipeGestureRecognizerDirection.down:
                SwipeDown()
            case UISwipeGestureRecognizerDirection.left:
                DoaFlip()
            case UISwipeGestureRecognizerDirection.up:
                SwipeUp()
            default:
                break
            }
        }
    }
    
    
    
    func initView()
    {
    keywordText.text = keyword
    phraseText.text = phrase
    oldkey = keyword
    oldphrase = phrase
    phraseText.isHidden = true
    keywordText.isHidden = false
    
    SaveButton.isHidden = true
    CancelButton.isHidden = true
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
        self.phraseText!.delegate = self
        self.keywordText.delegate = self
        
        
        
        initView()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "indexcard.png")
        backgroundImage.alpha = 0.3
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        bannerAd.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerAd.rootViewController = self
        bannerAd.load(GADRequest())
        
      
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

