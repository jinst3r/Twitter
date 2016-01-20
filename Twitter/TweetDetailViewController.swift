//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Jon Choi on 5/21/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweet: Tweet?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(tweet?.user?.name)")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        // hide empty cells and set a background color
        let hiddenView = UIView(frame: CGRectZero)
        tableView.tableFooterView = hiddenView
        tableView.tableFooterView!.hidden = true
        tableView.backgroundColor = UIColor(red: 245.0/255.0, green: 248.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("TweetDetailCell", forIndexPath: indexPath) as! TweetDetailCell
            // cleanUpMargin()
            print("\(tweet?.user?.name) here too")
            cell.tweetDetail = tweet
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("RetweetAndFavoriteCell", forIndexPath: indexPath) as! RetweetAndFavoriteCell
            // cleanUpMargin()
            print("this works, why don't you?")
            cell.tweetRetweetandFavorite = tweet
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ReplyRetweetFavoriteCell", forIndexPath: indexPath) as! ReplyRetweetFavoriteCell
            // cleanUpMargin()
            cell.tweetReplyRetweetFavorite = tweet
            return cell
        } else {
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "replySegue" {
            
            let replyUser = tweet?.user!.screenname!
            let tweetComposeViewController = (segue.destinationViewController as! UINavigationController).topViewController as! TweetComposeViewController
            tweetComposeViewController.replyTweetTo = "@\(replyUser!)"
        } else if segue.identifier == "tweetDetailToProfileViewSegue" {
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetDetailCell
            if let indexPath = tableView.indexPathForCell(cell) {
                let navigationController = segue.destinationViewController as! UINavigationController
                var profilePageViewController = navigationController.topViewController as! ProfilePageViewController
                profilePageViewController.tweet = tweet
//                profilePageViewController.tweet?.retweeted = cell.retweetBoolCell
//                profilePageViewController.tweet?.favorited = cell.favoriteBoolCell
//                profilePageViewController.tweet?.retweetCount! = cell.retweetCount!
//                profilePageViewController.tweet?.favoriteCount! = cell.favoriteCount!
//                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }


    
    func cleanUpMargin() {
        let cell = UITableViewCell()
        
        if (cell.respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:"))){
            cell.preservesSuperviewLayoutMargins = false
        }
        if (cell.respondsToSelector(Selector("setSeparatorInset:"))){
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        if (cell.respondsToSelector(Selector("setLayoutMargins:"))){
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }

}
