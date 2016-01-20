//
//  ViewController.swift
//  Twitter
//
//  Created by Jon Choi on 5/18/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBAction func onLogin(sender: AnyObject) {
        print("I clicked this")
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                print("I clicked this and got here 1")                
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                print("I clicked this and got here 2")
            }
        }

    }
}

