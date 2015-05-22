//
//  TweetCell.swift
//  Twitter
//
//  Created by Jon Choi on 5/21/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
  
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var tweetNameLabel: UILabel!
    @IBOutlet weak var tweetHandleLabel: UILabel!
    @IBOutlet weak var tweetTimeLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!

    // hack until i can figure out persistence or delegate
    var retweetBoolCell: Bool?
    var favoriteBoolCell: Bool?
    var retweetCount: Int?
    var favoriteCount: Int?
    
    var tweet: Tweet! {
        didSet {
            tweetImageView.setImageWithURL(NSURL(string: "\(tweet.user!.profileImageUrl!)"))
            tweetNameLabel.text = tweet.user!.name
            tweetHandleLabel.text = "@\(tweet.user!.screenname!)"
            tweetTimeLabel.text = tweet.createdAtStringUsable!
            tweetContentLabel.text = tweet.text!
            retweetCount = tweet.retweetCount!
            favoriteCount = tweet.favoriteCount!
            retweetCountLabel.text = String(retweetCount!)
            favoriteCountLabel.text = String(favoriteCount!)
            retweetBoolCell = tweet.retweeted
            favoriteBoolCell = tweet.favorited
            
            if retweetBoolCell == true {
                retweetButton.setImage(UIImage(named: "retweet_on"), forState: .Normal)
            }
            
            if favoriteBoolCell == true {
                favoriteButton.setImage(UIImage(named: "favorite_on"), forState: .Normal)
            }

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetImageView.layer.cornerRadius = 4
        tweetImageView.clipsToBounds = true

        dispatch_async(dispatch_get_main_queue()) {
            self.tweetContentLabel.preferredMaxLayoutWidth = self.tweetContentLabel.frame.size.width
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.tweetContentLabel.preferredMaxLayoutWidth = self.tweetContentLabel.frame.size.width
    }
    
    //reply
    @IBAction func replyShadowButton(sender: AnyObject) {
    }
    
    //retweet
    @IBAction func retweetShadowButton(sender: AnyObject) {
        println("retweet button pressed")
        if retweetBoolCell! == false {
            println("attempting to retweet")
            println(retweetBoolCell)
            TwitterClient.sharedInstance.retweetTheTweet(tweet.id!, params: nil) { (error) -> () in
                self.retweetLabelOn()
                self.retweetBoolCell = true
                self.retweetCount! += 1
                self.retweetCountLabel.text = String(self.retweetCount!)
            }
        } else if retweetBoolCell! == true {
            println("attempting to UNretweet")
            println(retweetBoolCell)
            TwitterClient.sharedInstance.unretweetTheTweet(tweet.id!, params: nil) { (error) -> () in
                self.retweetLabelOff()
                self.retweetBoolCell = false
                self.retweetCount! -= 1
                self.retweetCountLabel.text = String(self.retweetCount!)
            }
        } else {
            println("what's going on?")
            println(retweeted)
        }
    }
    
    // favorite
    @IBAction func favoriteShadowButton(sender: AnyObject) {
        println(favoriteBoolCell!)
        
        if favoriteBoolCell! == false {
            println("attempting to favorite")
            println(favoriteBoolCell)
            TwitterClient.sharedInstance.favoriteTheTweet(tweet.id!, params: nil) { (error) -> () in
                self.favoriteLabelOn()
                self.favoriteBoolCell = true
                self.favoriteCount! += 1
                self.favoriteCountLabel.text = String(self.favoriteCount!)
                return
            }
        } else if favoriteBoolCell! == true {
            println("attempting to UNfavorite")
            println(favoriteBoolCell)
            TwitterClient.sharedInstance.unfavoriteTheTweet(tweet.id!, params: nil) { (error) -> () in
                self.favoriteLabelOff()
                self.favoriteBoolCell = false
                self.favoriteCount! -= 1
                self.favoriteCountLabel.text = String(self.favoriteCount!)
                return
            }
        } else {
            println("what's going on?")
            println(favoriteBoolCell)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // color labels
    func retweetLabelOn() {
        self.retweetButton.setImage(UIImage(named: "retweet_on"), forState: .Normal)
        self.retweetButton.alpha = 1.0
        self.retweetCountLabel.textColor = UIColor(red: 92.0/255.0, green: 145.0/255.0, blue: 59.0/255.0, alpha: 1.0)
    }
    
    func retweetLabelOff() {
        self.retweetButton.setImage(UIImage(named: "retweet"), forState: .Normal)
        self.retweetButton.alpha = 0.5
        self.retweetCountLabel.textColor = UIColor.lightGrayColor()
    }
    
    func favoriteLabelOn() {
        self.favoriteButton.setImage(UIImage(named: "favorite_on"), forState: .Normal)
        self.favoriteButton.alpha = 1.0
        self.favoriteCountLabel.textColor = UIColor(red: 255.0/255.0, green: 172.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    }
    
    func favoriteLabelOff() {
        self.favoriteButton.setImage(UIImage(named: "favorite"), forState: .Normal)
        self.favoriteButton.alpha = 0.5
        self.favoriteCountLabel.textColor = UIColor.lightGrayColor()
    }
}
