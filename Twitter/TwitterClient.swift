//
//  TwitterClient.swift
//  Twitter
//
//  Created by Jon Choi on 5/18/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

let twitterConsumerKey = "xNGzwn3ZpdGwRbMytG01hrEi5"
let twitterConsumerSecret = "XnKEKdOOTsS9dZkNoHsakMyos6fXfHC89IZKu6bv3bw5jpI7c4"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    // create a singleton
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
}
