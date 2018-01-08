//
//  IndexCard.swift
//  InCardio
//
//  Created by Nicholas Pound on 4/8/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import UIKit
import os

class IndexCard : NSObject, NSCoding {
    var keyword:String?
    var phrase:String?
    var created : NSDate?
    var changed : NSDate?

    
    
    init(keyword: String, phrase: String, created: NSDate, changed: NSDate)
    {
        
        self.keyword = keyword
        self.phrase = phrase
        self.created = created
        self.changed = changed
    }

    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(keyword: (aDecoder.decodeObject(forKey: "keyword") as! String),phrase: (aDecoder.decodeObject(forKey: "phrase") as! String) , created: (aDecoder.decodeObject(forKey: "created") as! NSDate), changed: (aDecoder.decodeObject(forKey: "changed") as! NSDate))
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(keyword, forKey: "keyword")
        aCoder.encode(phrase, forKey: "phrase")
        aCoder.encode(created, forKey: "created")
        aCoder.encode(changed, forKey: "changed")
        
    }

    
    
    
    
}
