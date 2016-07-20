//
//  AutoCompleteData.swift
//  Input101
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

import Foundation

class AutoCompleteData: NSObject {
    var name: String
    var imageString: String
    
    init(name: String, imageString: String) {
        self.name = name
        self.imageString = imageString
    }
    
    class func demoData() -> NSMutableArray {
        
        let dataArray = NSMutableArray()
        let array = ["Australia","Bangladesh","Brazil","Canada", "China", "France","Germany","India", "Japan", "Nepal", "Pakistan", "Srilanka"]
        let imageArray = ["Australia","Bangladesh","Brazil","Canada", "China", "France","Germany","India", "Japan", "Nepal", "Pakistan", "Srilanka"]
        
        for var i = 0; i < array.count; i++ {
            let data = AutoCompleteData(name: array[i],imageString: imageArray[i])
            dataArray.addObject(data)
        }
        
        return dataArray;
    }
}