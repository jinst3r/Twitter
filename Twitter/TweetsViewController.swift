//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Jon Choi on 5/21/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

@objc protocol CenterViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func toggleRightPanel()
    optional func collapseSidePanels()
}


class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]?

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    // for hamburger
    var delegate: CenterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200

        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        
        // refresh control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex:0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        if tweets != nil {
            cell.tweet = tweets![indexPath.row]
            println("now it's workin")
        } else {
            println("try again dummy")
        }
        
        
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
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            println("you suck/ number of rows didn't load hmm")
            return 0
        }
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TweetDetailSegue" {
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
        } else if segue.identifier == "replySegueTimeline" {
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetCell
            let indexPath = self.tableView.indexPathForCell(cell)
            var tweet = tweets![indexPath!.row]
            var replyUser = tweet.user!.screenname!
            let tweetComposeViewController = segue.destinationViewController.topViewController as! TweetComposeViewController
            tweetComposeViewController.replyTweetTo = "@\(replyUser)"
        } else if segue.identifier == "profilePageSegue" {
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetCell
            if let indexPath = tableView.indexPathForCell(cell) {
                let profilePageViewController = segue.destinationViewController as! ProfilePageViewController
                profilePageViewController.tweet = tweets?[indexPath.row]
                profilePageViewController.tweet?.retweeted = cell.retweetBoolCell
                profilePageViewController.tweet?.favorited = cell.favoriteBoolCell
                profilePageViewController.tweet?.retweetCount! = cell.retweetCount!
                profilePageViewController.tweet?.favoriteCount! = cell.favoriteCount!
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }

    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        self.refreshControl.endRefreshing()
    }
    
}

    