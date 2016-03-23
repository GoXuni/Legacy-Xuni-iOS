//
//  CustomerData.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class CustomerData: NSObject {
    var customerID: Int
    var firstName, lastName: String
    var address, postalCode, country: String
    var city: String
    var countryID: Int
    var email: String
    var lastOrderDate: NSDate
    var orderCount: Int
    var orderTotal: Double
    var active: Bool
    
    private override init()
    {
       
        self.customerID = 0
        self.countryID = 0
        self.firstName = ""
        self.lastName = ""
        self.active = false
        self.address = ""
        self.city = ""
        self.country = ""
        self.postalCode = ""
        self.lastOrderDate = NSDate()
        self.orderCount = 0
        self.orderTotal = 0.0
        self.email = ""
        super.init()
    }
    
    init(customerID: Int, countryID: Int, firstName first: String, lastName last: String, address: String, city: String, country: String, postalCode: String, email: String, lastOrderDate: NSDate, orderCount: Int, orderTotal: Double, active: Bool){
        self.customerID = customerID
        self.countryID = countryID
        self.firstName = first
        self.lastName = last
        self.active = active
        self.address = address
        self.city = city
        self.country = country
        self.postalCode = postalCode
        self.lastOrderDate = lastOrderDate
        self.orderCount = orderCount
        self.orderTotal = orderTotal
        self.email = email
    }
    
    class func generateRandomBool() -> Bool{
        let random = (Int(arc4random_uniform(UInt32(RAND_MAX))))
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

        let firstNames: String = "Andy|Ben|Charlie|Dan|Ed|Fred|Gil|Herb|Jack|Karl|Larry|Mark|Noah|Oprah|Paul|Quince|Rich|Steve|Ted|Ulrich|Vic|Xavier|Zeb"
        var firstNamesArray: [AnyObject] = firstNames.componentsSeparatedByString("|")
        let lastNames: String = "Ambers|Bishop|Cole|Danson|Evers|Frommer|Griswold|Heath|Jammers|Krause|Lehman|Myers|Neiman|Orsted|Paulson|Quaid|Richards|Stevens|Trask|Ulam"
        var lastNamesArray: [AnyObject] = lastNames.componentsSeparatedByString("|")
        let countries: String = "China|India|United States|Indonesia|Brazil|Pakistan|Bangladesh|Nigeria|Russia|Japan|Mexico|Philippines|Vietnam|Germany|Ethiopia|Egypt|Iran|Turkey|Congo|France|Thailand|United Kingdom|Italy|Myanmar"
        var countriesArray: [AnyObject] = countries.componentsSeparatedByString("|")
        let cities: String = "Honolulu|Los Angeles|San Francisco|Las Vegas|Cancun|Chicago|New York|San Paolo|Miami|Dublin|London|Paris|Addis-Abeba|St. Petersburg|Frankfurt|Istanbul|Isfahan|Cairo|Milano|New Delhi|Bangalor|Mumbai|Dhaka|Tokyo|Osaka|Bangkok|Yangon|Manila"
        var citiesArray: [AnyObject] = cities.componentsSeparatedByString("|")
        let streets: String = "1st St.|Victory St.|Central Ave.|822th St."
        var streetsArray: [AnyObject] = streets.componentsSeparatedByString("|")
        let emails: String = "info@google.com|info@apple.com|info@microsoft.com|info@samsung.com|info@oracle.com"
        var emailsArray: [AnyObject] = emails.componentsSeparatedByString("|")
        let now: NSDate = NSDate()
        var previousDate: NSDate
        let dateComps: NSDateComponents = NSDateComponents()
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        let array: NSMutableArray = NSMutableArray()
        for var i = 0; i < total; i++ {
            dateComps.day = (Int(CustomerData.generateRandom(1000)) * -1)
            previousDate = calendar.dateByAddingComponents(dateComps, toDate: now, options: NSCalendarOptions(rawValue: 0))!
            let customer: CustomerData = CustomerData()
            customer.customerID = i
            customer.countryID = CustomerData.generateRandom(countriesArray.count)
            customer.country = String(countriesArray[Int(customer.countryID)])
            customer.firstName = firstNamesArray[CustomerData.generateRandom(firstNamesArray.count)] as! String
            customer.lastName = lastNamesArray[CustomerData.generateRandom(lastNamesArray.count)] as! String
            customer.city = citiesArray[CustomerData.generateRandom(citiesArray.count)] as! String
            customer.address = streetsArray[CustomerData.generateRandom(streetsArray.count)]  as! String
            customer.postalCode = "\(self.generateRandom(9))\(self.generateRandom(9))\(self.generateRandom(9))\(self.generateRandom(9))\(self.generateRandom(9))"
            customer.lastOrderDate = previousDate
            customer.email = emailsArray[CustomerData.generateRandom(emailsArray.count)] as! String
            customer.orderCount = self.generateRandom(100)
            customer.orderTotal = Double(self.generateRandom(100)) / 100.0 + Double(self.generateRandom(90000))
            customer.active = CustomerData.generateRandomBool()
            array.addObject(customer)
        }
        return array
        
    }
}

