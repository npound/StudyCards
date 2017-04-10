//
//  icDeck.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/8/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import UIKit

class IndexCardDeck :NSObject, NSCoding {
    var deck:[IndexCard]
    var name:String
    
    
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!
    
    
    
    
    static let ArchiveURL = (documentDirectory.path) + ("decks")

    
    
    
    
    init(deck:[IndexCard], name:String)
    {
        self.deck = deck
        self.name = name
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(deck: (aDecoder.decodeObject(forKey: "indexDecks") as! [IndexCard]),name: (aDecoder.decodeObject(forKey: "deckName") as! String))
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "deckName")
        aCoder.encode(deck, forKey: "indexDecks")

    }
    
    
}
