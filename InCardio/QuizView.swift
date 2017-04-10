//
//  QuizView.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/9/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import UIKit
import os

class QuizView: UIViewController {
    
    
    @IBOutlet weak var phraseQuiz: UITextView!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var Points: UILabel!
    
    
    @IBAction func option1OnClick(_ sender: UIButton) {
        if(sender.titleLabel!.text == answer) {
            if(lost == false){
                let points = Int(Points.text!)!+1
                Points.text = String(points)}
        PlayQuiz()
        }
        else
        {
            sender.setTitleColor(UIColor.red, for: .normal)
            lost = true
        }
    }
    @IBAction func option2OnClick(_ sender: UIButton) {
        if(sender.titleLabel!.text == answer) {
            if(lost == false){
                let points = Int(Points.text!)!+1
                Points.text = String(points)}
            PlayQuiz()
        }
        else
        {
            sender.setTitleColor(UIColor.red, for: .normal)
            lost = true
        }
    }
    @IBAction func option3OnClick(_ sender: UIButton) {
        if(sender.titleLabel!.text == answer) {
            if(lost == false){
            let points = Int(Points.text!)!+1
                Points.text = String(points)}
            PlayQuiz()
        }
        else
        {
            sender.setTitleColor(UIColor.red, for: .normal)
            lost = true
        }
    }
    @IBAction func option4OnClick(_ sender: UIButton) {
        if(sender.titleLabel!.text == answer) {
            if(lost == false){
                let points = Int(Points.text!)!+1
                Points.text = String(points)}
            PlayQuiz()
        }
        else
        {
            sender.setTitleColor(UIColor.red, for: .normal)
            lost = true
        }
    }
    
    
    private func resetcolor()
    {
        option1.setTitleColor(UIColor.blue, for: .normal)
        option2.setTitleColor(UIColor.blue, for: .normal)
        option3.setTitleColor(UIColor.blue, for: .normal)
        option4.setTitleColor(UIColor.blue, for: .normal)
        
    }
    
    private func allhidden()
    {
        option1.isHidden = true
        option2.isHidden = true
        option3.isHidden = true
        option4.isHidden = true
    }
    
    
    
    
    
        var score = 0;
    var diff = 0
    var master : [IndexCardDeck]?
    var deck : [IndexCard]?
    var name : String?
    
    var hardDeck = [IndexCard]()
    var gamedeck = [IndexCard]()
    var answer = ""
    var lost = false
    var hard = false
    
    
    
    
    fileprivate func PlayQuiz()
    {
        
        lost = false
        resetcolor()
        
        if diff == 1 {EasyGame(opt: 2)}
        if diff == 2 {EasyGame(opt: 4)}
        if diff == 3 {
            hard = true
            EasyGame(opt: 4)}
        
    }
    
    
    private func BuildHardDeck()
    {
        hardDeck = deck!
        
        if master!.count > 1{
            for i in 0...master!.count-1{
                    if master![i].name != name{
                        if master![i].deck.count > 0 {
                for j in 0...master![i].deck.count-1
                        {
                            hardDeck.append(master![i].deck[j])
                    }
                }
                }
                }
    }
    
    }
    
    
    
    
    fileprivate func EasyGame(opt: Int)
    {
        if opt == 2
        {
        option3.isHidden = true
        option4.isHidden = true
        }
        
        if gamedeck.count < opt
        {
        gamedeck = deck!
            
            if gamedeck.count < opt
            {
                phraseQuiz.text = "Sorry, you need to make more index cards in this deck to play!"
                allhidden()
                return
            }
        }
        
        
        if hardDeck.count < 4 &&  hard == true
        {
            BuildHardDeck()
        }
        
        
        
        
        var options = [String]()
        
        var count = 0
        
        if hard == false {
        while(count != opt)
        {
            
            
            let cardnumber = arc4random_uniform(UInt32(Int32(gamedeck.count)))
            
            let card = gamedeck[Int(cardnumber)]
            
            if count == 0 {
                
                answer = card.keyword!
                phraseQuiz.text = card.phrase
            }
  
            options.append(card.keyword!)
            gamedeck.remove(at: Int(cardnumber))
            count += 1
        }
        }
        
        else
        {
            while(count != opt)
            {
                
                
                
                
                
                if count == 0 {
                    let cardnumber = arc4random_uniform(UInt32(Int32(gamedeck.count)))
                    let card = gamedeck[Int(cardnumber)]
                    answer = card.keyword!
                    phraseQuiz.text = card.phrase
                    options.append(card.keyword!)
                    gamedeck.remove(at: Int(cardnumber))
                    removehardcard(id: card)
                }
                
                else{
                    let cardnumber = arc4random_uniform(UInt32(Int32(hardDeck.count)))
                    let card = hardDeck[Int(cardnumber)]
                    options.append(card.keyword!)
                    hardDeck.remove(at: Int(cardnumber))
                }
                

                count += 1
            }
        }
        
        
        
        
        
        while(options.count > 1)
        {
            let choice = arc4random_uniform(UInt32(options.count))
            if options.count==4 {option4.setTitle(options[Int(choice)], for: .normal)}
            if options.count==3 {option3.setTitle(options[Int(choice)], for: .normal)}
            if options.count==2 {option2.setTitle(options[Int(choice)], for: .normal)}
            options.remove(at: Int(choice))
        }
        option1.setTitle(options[0], for: .normal)
        options.remove(at: 0)
        
    }
    
    private func removehardcard(id: IndexCard)
    {
        for i in 0...hardDeck.count-1
        {
            if id.keyword == hardDeck[i].keyword && id.phrase == hardDeck[i].phrase
            {
                hardDeck.remove(at: i)
                return
            }
        }
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gamedeck = deck!
        PlayQuiz()
        Points.text = String(0)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
