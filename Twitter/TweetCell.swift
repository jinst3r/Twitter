//
//  TweetCell.swift
//  Twitter
//
//  Created by Jon Choi on 5/21/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

protocol TweetCellReplyDelegate : class {
    func reply(tweetCell: TweetCell)
}

protocol TweetCellRetweetDelegate : class {
    func retweet(tweetCell: TweetCell)
}

protocol TweetCellFavoriteDelegate : class {
    func favorite(tweetCell: TweetCell)
}

class TweetCell: UITableViewCell {

    weak var replyDelegate: TweetCellReplyDelegate?
    weak var retweetDelegate: TweetCellRetweetDelegate?
    weak var favoriteDelegate: TweetCellFavoriteDelegate?
    
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var tweetNameLabel: UILabel!
    @IBOutlet weak var tweetHandleLabel: UILabel!
    @IBOutlet weak var tweetTimeLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var replyButton: UIImageView!
    @IBOutlet weak var retweetButton: UIImageView!
    @IBOutlet weak var favoriteButton: UIImageView!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!

    let tapRec = UITapGestureRecognizer()

    var tweet: Tweet! {
        didSet {
            tweetImageView.setImageWithURL(NSURL(string: "\(tweet.user!.profileImageUrl!)"))
            tweetNameLabel.text = tweet.user!.name
            tweetHandleLabel.text = "@\(tweet.user!.screenname!)"
            tweetTimeLabel.text = tweet.createdAtStringUsable!
            tweetContentLabel.text = tweet.text!
            replyButton.image = UIImage(named: "reply")
            retweetButton.image = UIImage(named: "retweet")
            favoriteButton.image = UIImage(named: "favorite")
            retweetCountLabel.text = String(tweet.retweetCount!)
            favoriteCountLabel.text = String(tweet.favoriteCount!)
            tapRec.addTarget(replyButton, action: "tappedReply")
            tapRec.addTarget(retweetButton, action: "tappedRetweet")
            tapRec.addTarget(favoriteButton, action: "tappedFavorite")
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
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tappedReply() {
        println("reply tapped")
    }
    
    func tappedRetweet() {
        println("retweet tapped")
    }

    func tappedFavorite() {
        println("favorite tapped")
        favoriteDelegate?.favorite(self)
    }

    
}
