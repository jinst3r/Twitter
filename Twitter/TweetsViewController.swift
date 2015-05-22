//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Jon Choi on 5/21/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]?

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    func favorite(tweetCell: TweetCell) {
        TwitterClient.sharedInstance.favoriteTheTweet(tweetCell.tweet!.id!, params: nil) { (error) -> () in
            tweetCell.favoriteButton.image = UIImage(named: "favorite_on")
            let tweetInstance = tweetCell.tweet! as Tweet
            if tweetInstance.favoriteCount! > 0 {
                tweetCell.favoriteCountLabel.text = "\(tweetInstance.favoriteCount! + 1)"
            } else {
                tweetCell.favoriteCountLabel.text = "1"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250

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
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        println("and how about here \(tweets)")
        if tweets != nil {
            cell.tweet = tweets![indexPath.row]
            println("now it's workin")
        } else {
            println("try again dummy")
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
