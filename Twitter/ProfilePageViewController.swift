//
//  ProfilePageViewController.swift
//  Twitter
//
//  Created by Jon Choi on 5/30/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class ProfilePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweet: Tweet?
    var tweets: [Tweet]?
    // pass in user screenname to load
    
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200

        TwitterClient.sharedInstance.userTimeline(tweet!.user!.screenname!, completion: { (tweets, error) -> () in
            self.tweets = tweets
            println("user timeline called")
            println("here it is called \(self.tweets)")
            self.tableView.reloadData()
        })
        // refresh control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex:0)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: UITableViewCell!
        
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
            cell.tweet = tweets![0]
            println("profilecell tweet \(cell.tweet)")
            return cell
        } else if indexPath.section == 1 {
            var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
            
            println("tweetcell tweet tweet \(tweets![0])")
            cell.tweet = tweets![indexPath.row]
            println("\(cell.tweetImageButton)")
            println("tweetcell tweet \(cell.tweet)")
            return cell
        } else {
            println("anything here?")            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && tweets != nil {
            println("one profile view row hereeeeee")
            return 1
        } else if section == 1 && tweets != nil {
            println("some tweet view rows hereeeeee")
            return tweets!.count
        } else {
            return 0
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "profileTweetCellDetailSegue" {
            let cell = sender as! TweetCell
            if let indexPath = tableView.indexPathForCell(cell) {
                let tweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
                tweetDetailViewController.tweet = tweets?[indexPath.row]
                // hack for now
                tweetDetailViewController.tweet?.retweeted = cell.retweetBoolCell
                tweetDetailViewController.tweet?.favorited = cell.favoriteBoolCell
                tweetDetailViewController.tweet?.retweetCount! = cell.retweetCount!
                tweetDetailViewController.tweet?.favoriteCount! = cell.favoriteCount!
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        
        }
    }
}