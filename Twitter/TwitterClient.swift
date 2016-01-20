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
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            print("got home timeline")
//            for tweet in tweets {
//                println("tweet: \(tweet), text: \(tweet.text), created: \(tweet.createdAt)")
//            }
//            print(tweets)

        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            print("error getting home timeline")
            completion(tweets: nil, error: nil)
        })
        
    }

    func userTimeline(screenName: String, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/user_timeline.json", parameters: ["screen_name": screenName], success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            print("got user timeline")
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("error getting user timeline")
                completion(tweets: nil, error: nil)
        })
        
    }
    
    func postNewTweet(tweetStatus: String, completion: (error: NSError?) -> ()) {
        POST("1.1/statuses/update.json", parameters: ["status": tweetStatus], success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            print("tweeted!")
            completion(error: nil)
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            print("error in tweeting")
            completion(error: error)
        }
    )}
    
    
    func retweetTheTweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> ()) {
        POST("1.1/statuses/retweet/\(id).json", parameters: params, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            print("retweeted!")
            completion(error: nil)
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            print("error in retweeting")
            completion(error: error)
        }
    )}
    
    func unretweetTheTweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> ()) {
        POST("1.1/statuses/destroy/\(id).json", parameters: params, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            print("unretweeted!")
            completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("error in unretweeting")
                completion(error: error)
            }
        )}

    func favoriteTheTweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> ()) {
        POST("1.1/favorites/create.json?id=\(id)", parameters: params, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            print("favorited!")
            completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("error in favoriting")
                completion(error: error)
            }
        )}
    
    func unfavoriteTheTweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> ()) {
        POST("1.1/favorites/destroy.json?id=\(id)", parameters: params, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            print("unfavorited!")
            completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("error in unfavoriting")
                completion(error: error)
            }
        )}
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        print("got login request here")
        // Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        print("got login request here 2")
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            // force unwrap
            UIApplication.sharedApplication().openURL(authURL!)
            
        }) { (error: NSError!) -> Void in
            print("Failed to get request token")
            self.loginCompletion?(user: nil, error: error)
        }
        print("got login request here 3")
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            // user
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                // println("user: \(response)")
                let user = User(dictionary:response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("error getting current user")
                self.loginCompletion?(user: nil, error: error)
            })
            
            // home timeline
            
        }) { (error: NSError!) -> Void in
            print("Failed to receive access token")
            self.loginCompletion?(user: nil, error: error)
        }

    }
    
}
