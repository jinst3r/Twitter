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
    var hamburger: Bool?
    var screenname: String?
    var currUser: User?
    // pass in user screenname to load
    
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200

        if hamburger == true {
           print("hamburger true")
           screenname = currUser?.screenname
        } else {
           print("hamburger false")
           screenname = tweet!.user!.screenname!
        }
        
        TwitterClient.sharedInstance.userTimeline(screenname!, completion: { (tweets, error) -> () in
            self.tweets = tweets
            print("user timeline called")
            print("here it is called \(self.tweets)")
            self.tableView.reloadData()
        })
        // refresh control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex:0)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
            cell.tweet = tweets![0]
            print("profilecell tweet \(cell.tweet)")
            
            // gets rid of white margin on the left hand side
            if (cell.respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:"))){
                cell.preservesSuperviewLayoutMargins = false
            }
            if (cell.respondsToSelector(Selector("setSeparatorInset:"))){
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
            }
            if (cell.respondsToSelector(Selector("setLayoutMargins:"))){
                cell.layoutMargins = UIEdgeInsetsZero
            }

            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
            
            print("tweetcell tweet tweet \(tweets![0])")
            cell.tweet = tweets![indexPath.row]
            print("\(cell.tweetImageButton)")
            print("tweetcell tweet \(cell.tweet)")
            
            if cell.tweet.retweeted == true {
                cell.retweetLabelOn()
            } else {
                cell.retweetLabelOff()
            }
            
            if cell.tweet.favorited == true {
                cell.favoriteLabelOn()
            } else {
                cell.favoriteLabelOff()
            }
            
            // gets rid of white margin on the left hand side
            if (cell.respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:"))){
                cell.preservesSuperviewLayoutMargins = false
            }
            if (cell.respondsToSelector(Selector("setSeparatorInset:"))){
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
            }
            if (cell.respondsToSelector(Selector("setLayoutMargins:"))){
                cell.layoutMargins = UIEdgeInsetsZero
            }

            return cell
        } else {
            print("anything here?")            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && tweets != nil {
            print("one profile view row hereeeeee")
            return 1
        } else if section == 1 && tweets != nil {
            print("some tweet view rows hereeeeee")
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
    
    func onRefresh() {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        self.refreshControl.endRefreshing()
    }
    

}