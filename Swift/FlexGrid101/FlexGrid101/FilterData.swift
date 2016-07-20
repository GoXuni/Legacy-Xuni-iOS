//
//  SharedFilterData.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//
import Foundation


class FilterOperation: NSObject {
    var title: String
    var identifier: Int
    
    override init()
    {
        title=""
        identifier = 0
        super.init()
    }

    class func defaultOperations() -> [FilterOperation] {
        let operations: String = "Contains|StartsWith|EndsWith|EqualsText"
        let operationsArray: [String] = operations.componentsSeparatedByString("|")
        var result: [FilterOperation] = [FilterOperation]()
        for operation: String in operationsArray {
            let oper: FilterOperation = FilterOperation()
            oper.title = operation
            oper.identifier = operationsArray.indexOf(operation)!
            result.append(oper)
        }
        return result
    }
}

class FilterData: NSObject {
    var filterColumn: String
    var filterOperation: Int
    var filterString: String!
    
    override init()
    {
        filterColumn = ""
        filterOperation = 0
        filterString = ""
        super.init()
    }
    
    static var sharedInstance: NSMutableArray! = nil

    class func sharedFilterData() -> NSMutableArray! {
       
        let lockQueue = dispatch_queue_create("com.test.LockQueue", nil)
        
        dispatch_sync(lockQueue) {
            if (sharedInstance == nil) {
                sharedInstance = NSMutableArray()
            }
        }
        return sharedInstance!
    }
}
//
//  SharedFilterData.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//