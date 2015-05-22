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

    let tapRec = UITapGestureRecognizer()

    var tweet: Tweet! {
        didSet {
            tweetImageView.setImageWithURL(NSURL(string: "\(tweet.user!.profileImageUrl!)"))
            tweetNameLabel.text = tweet.user!.name
            tweetHandleLabel.text = "@\(tweet.user!.screenname!)"
            tweetTimeLabel.text = tweet.createdAtStringUsable!
            tweetContentLabel.text = tweet.text!
            retweetCountLabel.text = String(tweet.retweetCount!)
            favoriteCountLabel.text = String(tweet.favoriteCount!)
            retweeted = tweet.retweeted
            favorited = tweet.favorited
            if retweeted == true {
                retweetButton.setImage(UIImage(named: "retweet_on"), forState: .Normal)
                retweetButton.alpha = 1.0
                retweetCountLabel.textColor = UIColor(red: 92.0/255.0, green: 145.0/255.0, blue: 59.0/255.0, alpha: 1.0)
            }
            if favorited == true {
                favoriteButton.setImage(UIImage(named: "favorite_on"), forState: .Normal)
                favoriteButton.alpha = 1.0
                favoriteCountLabel.textColor = UIColor(red: 255.0/255.0, green: 172.0/255.0, blue: 51.0/255.0, alpha: 1.0)
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
    
    @IBAction func replyShadowButton(sender: AnyObject) {
        println("finally YES")
    }
    @IBAction func retweetShadowButton(sender: AnyObject) {
        if retweeted == false {
            TwitterClient.sharedInstance.retweetTheTweet(tweet.id!, params: nil) { (error) -> () in
                self.retweetButton.setImage(UIImage(named: "retweet_on"), forState: .Normal)
                self.retweetButton.alpha = 1.0
                self.retweetCountLabel.textColor = UIColor(red: 92.0/255.0, green: 145.0/255.0, blue: 59.0/255.0, alpha: 1.0)
            }
        } else {
            // unretweet
        }
    }
    @IBAction func favoriteShadowButton(sender: AnyObject) {
        if favorited == false {
            TwitterClient.sharedInstance.favoriteTheTweet(tweet.id!, params: nil) { (error) -> () in
                self.favoriteButton.setImage(UIImage(named: "favorite_on"), forState: .Normal)
                self.favoriteButton.alpha = 1.0
                self.favoriteCountLabel.textColor = UIColor(red: 255.0/255.0, green: 172.0/255.0, blue: 51.0/255.0, alpha: 1.0)
            }
        } else {
            // unretweet
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
