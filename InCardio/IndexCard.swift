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
    

    
    
    init(keyword: String, phrase: String)
    {
        
        self.keyword = keyword
        self.phrase = phrase
    }

    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(keyword: (aDecoder.decodeObject(forKey: "keyword") as! String),phrase: (aDecoder.decodeObject(forKey: "phrase") as! String))
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(keyword, forKey: "keyword")
        aCoder.encode(phrase, forKey: "phrase")
        
    }

    
    
    
    
}
