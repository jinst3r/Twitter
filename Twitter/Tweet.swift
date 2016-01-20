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
    var id: Int?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var createdAtStringUsable: String?
    var retweetCount: Int?
    var favoriteCount: Int?
    var retweeted: Bool?
    var favorited: Bool?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        retweetCount = dictionary["retweet_count"] as? Int
        favoriteCount = dictionary["favorite_count"] as? Int
        id = dictionary["id"] as? Int
        retweeted = dictionary["retweeted"] as? Bool
        favorited = dictionary["favorited"] as? Bool
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        let simpleFormatter = NSDateFormatter()
        // just show hour?
        // simpleFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
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
