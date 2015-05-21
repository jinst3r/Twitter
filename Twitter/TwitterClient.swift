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
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    // create a singleton
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }

    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println("home timeline: \(response)")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            println("got home timeline")
//            for tweet in tweets {
//                println("tweet: \(tweet), text: \(tweet.text), created: \(tweet.createdAt)")
//            }
//            print(tweets)
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println("error getting home timeline")
            completion(tweets: nil, error: nil)
        })
        
    }

    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion

        // Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            println("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            // force unwrap
            UIApplication.sharedApplication().openURL(authURL!)
            
        }) { (error: NSError!) -> Void in
            println("Failed to get request token")
            self.loginCompletion?(user: nil, error: error)
        }

    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            println("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            // user
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                // println("user: \(response)")
                var user = User(dictionary:response as! NSDictionary)
                User.currentUser = user
                println("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting current user")
                self.loginCompletion?(user: nil, error: error)
            })
            
            // home timeline
            
        }) { (error: NSError!) -> Void in
            println("Failed to receive access token")
            self.loginCompletion?(user: nil, error: error)
        }

    }
    
}
