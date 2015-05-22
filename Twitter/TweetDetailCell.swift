//
//  TweetDetailCell.swift
//  Twitter
//
//  Created by Jon Choi on 5/21/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class TweetDetailCell: UITableViewCell {

    @IBOutlet weak var tweetDetailImageView: UIImageView!
    @IBOutlet weak var tweetDetailNameLabel: UILabel!
    @IBOutlet weak var tweetDetailHandleLabel: UILabel!
    @IBOutlet weak var tweetDetailContentLabel: UILabel!
    @IBOutlet weak var tweetDetailTimeLabel: UILabel!
    
    var tweetDetail: Tweet! {
        didSet {
            tweetDetailImageView.setImageWithURL(NSURL(string: "\(tweetDetail.user!.profileImageUrl!)"))
            tweetDetailNameLabel.text = tweetDetail.user!.name
            tweetDetailHandleLabel.text = "@\(tweetDetail.user!.screenname!)"
            tweetDetailTimeLabel.text = tweetDetail.createdAtStringUsable!
            tweetDetailContentLabel.text = tweetDetail.text!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetDetailImageView.layer.cornerRadius = 4
        tweetDetailImageView.clipsToBounds = true
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tweetDetailContentLabel.preferredMaxLayoutWidth = self.tweetDetailContentLabel.frame.size.width
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
            
        self.tweetDetailContentLabel.preferredMaxLayoutWidth = self.tweetDetailContentLabel.frame.size.width
    }
        
        
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
