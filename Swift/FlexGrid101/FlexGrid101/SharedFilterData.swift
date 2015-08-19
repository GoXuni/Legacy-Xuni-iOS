//
//  SharedFilterData.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import Foundation

class SharedFilterData {
    class var sharedInstance: SharedFilterData {
        struct Static {
            static var token: dispatch_once_t = 0
            static var instance: SharedFilterData? = nil
        }

        dispatch_once(&Static.token){
            Static.instance = SharedFilterData()
        }
        return Static.instance!
    }
    var filterSet: Bool!
    var filterOperation: Int!
    var filterString: String!
}
