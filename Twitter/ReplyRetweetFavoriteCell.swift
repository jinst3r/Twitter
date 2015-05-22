//
//  ReplyRetweetFavoriteCell.swift
//  Twitter
//
//  Created by Jon Choi on 5/21/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

var retweeted: Bool?
var favorited: Bool?

class ReplyRetweetFavoriteCell: UITableViewCell {

    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!


    var tweetReplyRetweetFavorite: Tweet! {
        didSet {
            retweeted = tweetReplyRetweetFavorite.retweeted
            favorited = tweetReplyRetweetFavorite.favorited
        
            if retweeted == true {
            retweetButton.setImage(UIImage(named: "retweet_on"), forState: .Normal)
            }
            
            if favorited == true {
            favoriteButton.setImage(UIImage(named: "favorite_on"), forState: .Normal)
            }

        }
    }
    
    @IBAction func replyButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func retweetButtonTapped(sender: AnyObject) {
        if retweeted == false {
            TwitterClient.sharedInstance.retweetTheTweet(tweetReplyRetweetFavorite!.id!, params: nil) { (error) -> () in
                self.retweetButton.setImage(UIImage(named: "retweet_on"), forState: .Normal)
            }
        } else {
            // unretweet
        }
    }
    
    @IBAction func favoriteButtonTapped(sender: AnyObject) {
        if favorited == false {
            TwitterClient.sharedInstance.favoriteTheTweet(tweetReplyRetweetFavorite!.id!, params: nil) { (error) -> () in
                self.favoriteButton.setImage(UIImage(named: "favorite_on"), forState: .Normal)
            }
        } else {
            // unfavorite
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
