//
//  YouTubeCollectionView.h
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreDynamicKit
class YouTubeCollectionView: XuniCursorCollectionView {
    var query: String

    var orderBy: String


    init(query: String, orderBy: String) {
            self.query = query
            self.orderBy = orderBy
            self.pageToken = ""
            super.init()
    }

    override func hasMoreItems() -> Bool {
        return true
    }
    
    override func itemGetter(desiredNumber: NSNumber!) -> NSMutableArray!
    {
        let dataToAppend = NSMutableArray()
        
        let urlAddress: String = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&q=\(query.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!)&order=\(orderBy)&maxResults=\(desiredNumber)\(NSString(string: pageToken).length==0 ? "&pageToken=\(pageToken)" : "")&key=\("AIzaSyDFz8V9U0ccKXQ5oSrcRSoHqpaursqOudo")"
        
        let dataResult: NSData! = NSData(contentsOfURL: NSURL(string: urlAddress)!)
        
        if(dataResult == nil)
        {
            return dataToAppend
        }
        
        let object: AnyObject! = try! NSJSONSerialization.JSONObjectWithData(dataResult, options: NSJSONReadingOptions())
        
        if (object is NSDictionary) {
            let results: NSDictionary = object as! NSDictionary
            self.pageToken = (results["nextPageToken"] as! String)
            
            let items: NSMutableArray = (results["items"] as! NSMutableArray)
            
            for index in 0 ..< items.count {
                let dict = items[index] as! NSDictionary
                let title: NSString = dict.valueForKeyPath("snippet.title") as! NSString
                let description: NSString = dict.valueForKeyPath("snippet.description")  as! NSString
                let sample: SampleData = SampleData(title: title.description, subtitle: description.description)
                sample.channelTitle = dict.valueForKeyPath("snippet.channelTitle") as! String
                sample.thumbnail = dict.valueForKeyPath("snippet.thumbnails.default.url") as! String
                
                let vidid = dict.valueForKeyPath("id.videoId") as! String
                sample.link = "http://www.youtube.com/watch?v=\(vidid)"
                dataToAppend.addObject(sample)
                
            }
        }
        
        return dataToAppend

    }

    var pageToken: String
}
//
//  YouTubeCollectionView.m
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//