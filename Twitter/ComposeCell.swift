//
//  ComposeCell.swift
//  Twitter
//
//  Created by Jon Choi on 5/21/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class ComposeCell: UITableViewCell {

    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var tweetNameLabel: UILabel!
    @IBOutlet weak var tweetScreennameLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    //@IBOutlet weak var tweetTextView: UITextView!
    
    var tweetCompose: User! {
        didSet {
            tweetImageView.setImageWithURL(NSURL(string: "\(tweetCompose.profileImageUrl!)"))
            tweetNameLabel.text = tweetCompose.name
            tweetScreennameLabel.text = tweetCompose.screenname
            tweetTextView.text = "What's happening?"
            tweetTextView.textColor = UIColor.lightGrayColor()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetImageView.layer.cornerRadius = 2
        tweetImageView.clipsToBounds = true
        
//        dispatch_async(dispatch_get_main_queue()) {
//            self.tweetTextView.preferred
//        }
    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//            
//        self.tweetTextView.preferredMaxLayoutWidth = self.tweetTextView.frame.size.width
//    }
        
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if tweetTextView.text == UIColor.lightGrayColor() {
            tweetTextView.text = nil
            tweetTextView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's happening?"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
  

}
