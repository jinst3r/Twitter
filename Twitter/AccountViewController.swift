//
//  AccountViewController.swift
//  Twitter
//
//  Created by Jon Choi on 5/31/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableVIew: UITableView!
    var currUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableVIew.delegate = self
        tableVIew.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableVIew.dequeueReusableCellWithIdentifier("AccountCell", forIndexPath: indexPath) as! AccountCell
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("accountSegueProfile", sender: self)
            print("to profile")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("preparing", terminator: "")
        if segue.identifier == "accountSegueProfile" {
            let navController = segue.destinationViewController as! UINavigationController
            let profileVC = navController.topViewController as! ProfilePageViewController
            profileVC.hamburger = true
            profileVC.currUser = User.currentUser
            print("prepared", terminator: "")
        }
    }
}
