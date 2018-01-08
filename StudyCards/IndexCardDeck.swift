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
    var created : NSDate?
    var changed : NSDate?
    
    
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!
    
    
    
    
    static let ArchiveURL = (documentDirectory.path) + ("/decks")

    
    
    
    
    init(deck:[IndexCard], name:String, created: NSDate, changed: NSDate)
    {
        self.deck = deck
        self.name = name
        self.created = created
        self.changed = changed
        
        
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(deck: (aDecoder.decodeObject(forKey: "indexDecks") as! [IndexCard]),name: (aDecoder.decodeObject(forKey: "deckName") as! String),created: (aDecoder.decodeObject(forKey: "created") as! NSDate),changed: (aDecoder.decodeObject(forKey: "changed") as! NSDate))
 
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "deckName")
        aCoder.encode(deck, forKey: "indexDecks")
        aCoder.encode(created, forKey: "created")
        aCoder.encode(changed, forKey: "changed")

    }
    
    
}
