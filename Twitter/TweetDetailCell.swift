//
//  TweetDetailCell.swift
//  Twitter
//
//  Created by Jon Choi on 5/21/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class TweetDetailCell: UITableViewCell {

    @IBOutlet weak var tweetDetailNameLabel: UILabel!
    @IBOutlet weak var tweetDetailHandleLabel: UILabel!
    @IBOutlet weak var tweetDetailContentLabel: UILabel!
    @IBOutlet weak var tweetDetailTimeLabel: UILabel!
    @IBOutlet weak var tweetDetailImageButton: UIButton!
    
    var tweetDetail: Tweet! {
        didSet {
            
            tweetDetailNameLabel.text = tweetDetail.user!.name
            tweetDetailHandleLabel.text = "@\(tweetDetail.user!.screenname!)"
            tweetDetailTimeLabel.text = tweetDetail.createdAtStringUsable!
            tweetDetailContentLabel.text = tweetDetail.text!
            // tweetDetailImageButton.setImage(UIImage(data: NSData(contentsOfURL: NSURL(string: "\(tweetDetail.user!.profileImageUrl!)")!)!), forState: .Normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tweetDetailImageButton?.layer.masksToBounds = true
        tweetDetailImageButton?.layer.cornerRadius = 8.0
        tweetDetailImageButton?.clipsToBounds = true
        
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

    @IBAction func tweetDetailImageButtonTapped(sender: UIButton) {
        print("tapped dat")
    }
    
    
}
