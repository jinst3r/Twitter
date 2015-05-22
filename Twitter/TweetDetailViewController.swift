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
        
        println("\(tweet?.user?.name)")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        // hide empty cells and set a background color
        var hiddenView = UIView(frame: CGRectZero)
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
        
        var cell:UITableViewCell!

        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier("TweetDetailCell", forIndexPath: indexPath) as! TweetDetailCell
            // cleanUpMargin()
            println("\(tweet?.user?.name) here too")
            cell.tweetDetail = tweet
            return cell
        } else if indexPath.section == 1 {
            var cell = tableView.dequeueReusableCellWithIdentifier("RetweetAndFavoriteCell", forIndexPath: indexPath) as! RetweetAndFavoriteCell
            // cleanUpMargin()
            cell.tweetRetweetandFavorite = tweet
            return cell
        } else if indexPath.section == 2 {
            var cell = tableView.dequeueReusableCellWithIdentifier("ReplyRetweetFavoriteCell", forIndexPath: indexPath) as! ReplyRetweetFavoriteCell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func cleanUpMargin() {
        var cell:UITableViewCell!
        
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
