//
//  TweetComposeViewController.swift
//  Twitter
//
//  Created by Jon Choi on 5/21/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class TweetComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    
    var replyTweetTo: String?
    
    @IBAction func postTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.postNewTweet(textView.text, completion: { (error) -> () in
            self.dismissViewControllerAnimated(true, completion: nil)
            println("tweet attempted")
        })
 
    }
    
    @IBAction func cancelTweet(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        imageLabel.setImageWithURL(NSURL(string: _currentUser!.profileImageUrl!))
        nameLabel.text = _currentUser!.name!
        screennameLabel.text = "@\(_currentUser!.screenname!)"

        if replyTweetTo != nil {
            textView.text = replyTweetTo
            textView.textColor = UIColor.blackColor()
        } else {
            textView.text = "What's happening?"
            textView.textColor = UIColor.lightGrayColor()
        }
        
        imageLabel.layer.cornerRadius = 4
        imageLabel.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's happening?"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
