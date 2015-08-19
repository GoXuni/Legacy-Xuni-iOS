//
//  CustomerData.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class CustomerData: NSObject {
    var customerID, countryID, weight : Double
    var first, last, father, brother, cousin : String
    var active : Bool
    var hireDate : NSDate
    init(customerID: Double, countryID: Double, weight: Double, first: String, last: String, father: String, brother: String, cousin: String, active: Bool, hireDate: NSDate){
        self.customerID = customerID
        self.countryID = countryID
        self.weight = weight
        self.first = first
        self.last = last
        self.father = father
        self.brother = brother
        self.cousin = cousin
        self.active = active
        self.hireDate = hireDate
    }
    class func generateRandomBool() -> Bool{
        var random = (Int(arc4random_uniform(UInt32(RAND_MAX))))
        if (random % 5 == 0) {
            return true
        }
        else{
            return false
        }
    }
    class func generateRandom(max: Int) -> Int{
        return (Int(arc4random_uniform(UInt32(max))))
    }
    class func getCustomerData(total: Int) -> NSMutableArray{
        var array = NSMutableArray()
        var firstNames : String = "Andy|Ben|Charlie|Dan|Ed|Fred|Gil|Herb|Jack|Karl|Larry|Mark|Noah|Oprah|Paul|Quince|Rich|Steve|Ted|Ulrich|Vic|Xavier|Zeb"
        let firstNamesArray = firstNames.componentsSeparatedByString("|")
        var lastNames : String = "Ambers|Bishop|Cole|Danson|Evers|Frommer|Griswold|Heath|Jammers|Krause|Lehman|Myers|Neiman|Orsted|Paulson|Quaid|Richards|Stevens|Trask|Ulam"
        let lastNamesArray = lastNames.componentsSeparatedByString("|")
        var countries :String = "China|India|United States|Indonesia|Brazil|Pakistan|Bangladesh|Nigeria|Russia|Japan|Mexico|Philippines|Vietnam|Germany|Ethiopia|Egypt|Iran|Turkey|Congo|France|Thailand|United Kingdom|Italy|Myanmar"
        let countriesArray = countries.componentsSeparatedByString("|")
        var now = NSDate()
        var previousDate = NSDate()
        for var i = 0; i < total; i++ {
            previousDate = now.dateByAddingTimeInterval(-24 * 60 * 60 * Double(self.generateRandom(1000)))
            var customer = CustomerData(customerID: Double(i), countryID: Double(self.generateRandom(countriesArray.count)), weight: Double(self.generateRandom(150) + 100), first: firstNamesArray[self.generateRandom(firstNamesArray.count)], last: lastNamesArray[self.generateRandom(lastNamesArray.count)], father: firstNamesArray[self.generateRandom(firstNamesArray.count)], brother: firstNamesArray[self.generateRandom(firstNamesArray.count)], cousin: firstNamesArray[self.generateRandom(firstNamesArray.count)], active: self.generateRandomBool(), hireDate: previousDate)
            array.addObject(customer)
        }
        return array
    }
}
