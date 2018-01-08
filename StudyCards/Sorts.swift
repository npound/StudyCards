//
//  Sorts.swift
//  Study Cards
//
//  Created by Nicholas Pound on 4/12/17.
//  Copyright © 2017 Nicholas Pound. All rights reserved.
//

import Foundation
class Utils
{
    
    
    
    
    
    
    
    
}

extension NSDate {
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
}
}
extension String{
    
    func isGreater(stringCompared : String) -> Bool{
        
        if(self.caseInsensitiveCompare(stringCompared) == ComparisonResult.orderedDescending){
            return true
        }
return false
        }
        
    }
    
    
    
