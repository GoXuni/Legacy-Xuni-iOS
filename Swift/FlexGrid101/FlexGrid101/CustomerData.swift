//
//  CustomerData.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//
import Foundation
class CountryPair: NSObject {
    var title: String
    var identifier: Int
    
    override init()
    {
        title = ""
        identifier = 0
        super.init()
    }
}
class CustomerData: NSObject {
    var customerID: Int
    var firstName: String
    var lastName: String
    var name: String {
        get {
            return "\(self.firstName) \(self.lastName)"
        }
    }

    var address: String
    var city: String
    var countryID: Int
    var country: String
    var postalCode: String
    var email: String
    var lastOrderDate: NSDate
    var orderCount: Int
    var orderTotal: Double
    var orderAverage: Double {
        get {
            return self.orderTotal / (Double(self.orderCount))
        }
    }

    var active: Bool
    
    override init()
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
        self.orderTotal = 0
        self.email = ""
        super.init()
    }

    init(customerID: Int, countryID: Int, firstName first: String, lastName last: String, address: String, city: String, country: String, postalCode: String, lastOrderDate: NSDate, orderCount: Int, orderTotal: Double, active: Bool) {
        
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
        self.email = ""
        super.init()
    }

    class func getCustomerData(total: Int) -> [CustomerData] {
        let firstNames: String = "Andy|Ben|Charlie|Dan|Ed|Fred|Gil|Herb|Jack|Karl|Larry|Mark|Noah|Oprah|Paul|Quince|Rich|Steve|Ted|Ulrich|Vic|Xavier|Zeb"
        let firstNamesArray: [AnyObject] = firstNames.componentsSeparatedByString("|")
        let lastNames: String = "Ambers|Bishop|Cole|Danson|Evers|Frommer|Griswold|Heath|Jammers|Krause|Lehman|Myers|Neiman|Orsted|Paulson|Quaid|Richards|Stevens|Trask|Ulam"
        let lastNamesArray: [AnyObject] = lastNames.componentsSeparatedByString("|")
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
        var array: [CustomerData] = [CustomerData]()
        for i in 0 ..< total {
            dateComps.second = (CustomerData.generateRandom(100000000) * -1)
            previousDate = calendar.dateByAddingComponents(dateComps, toDate: now, options:NSCalendarOptions())!
            let customer: CustomerData = CustomerData()
            customer.customerID = i
            customer.countryID = CustomerData.generateRandom(countriesArray.count)
            customer.country = countriesArray[customer.countryID] as! String
            customer.firstName = firstNamesArray[CustomerData.generateRandom(firstNamesArray.count)] as! String
            customer.lastName = lastNamesArray[CustomerData.generateRandom(lastNamesArray.count)] as! String
            customer.city = citiesArray[CustomerData.generateRandom(citiesArray.count)] as! String
            customer.address = "\(Int(CustomerData.generateRandom(500))) \(streetsArray[CustomerData.generateRandom(streetsArray.count)])"
            customer.postalCode = "\(self.generateRandom(9))\(self.generateRandom(9))\(self.generateRandom(9))\(self.generateRandom(9))\(self.generateRandom(9))"
            customer.lastOrderDate = previousDate
            customer.email = emailsArray[CustomerData.generateRandom(emailsArray.count)] as! String
            customer.orderCount = self.generateRandom(100) + 1
            customer.orderTotal = Double(self.generateRandom(100)) / 100.0 + Double(self.generateRandom(90000))
            customer.active = CustomerData.generateRandomBool()
            array.append(customer)
        }
        return array
    }

    class func defaultCountries() -> [CountryPair] {
        let countries: String = "China|India|United States|Indonesia|Brazil|Pakistan|Bangladesh|Nigeria|Russia|Japan|Mexico|Philippines|Vietnam|Germany|Ethiopia|Egypt|Iran|Turkey|Congo|France|Thailand|United Kingdom|Italy|Myanmar"
        let countriesArray: [String] = countries.componentsSeparatedByString("|")
        var result: [CountryPair] = [CountryPair]()
        for country: String in countriesArray {
            let pair: CountryPair = CountryPair()
            pair.title = country
            pair.identifier = countriesArray.indexOf(country)!
            result.append(pair)
        }
        return result
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
}