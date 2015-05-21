//
//  Tweet.swift
//  Twitter
//
//  Created by Jon Choi on 5/19/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var createdAtStringUsable: String?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String

        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        var simpleFormatter = NSDateFormatter()
        // just show hour?
        simpleFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        simpleFormatter.timeStyle = .ShortStyle
        createdAtStringUsable = simpleFormatter.stringFromDate(createdAt!)

    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
