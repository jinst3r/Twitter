//
//  SideMenuViewController.swift
//  Twitter
//
//  Created by Jon Choi on 5/30/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

@objc protocol SideMenuViewControllerDelegate {
    optional func animateSideMenu()
}

class SideMenuViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dummyView: UIView!

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SideMenuViewControllerDelegate?
    
    let menuArray = ["Profile", "Timeline", "Mentions", "Accounts"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
        print("i mean... it is loading")
    }
    
    override func viewDidAppear(animated: Bool) {
        print("it did appear....!")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 180
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        cell.menuLabel.text = menuArray[indexPath.row]
        print("cell \(indexPath.row) instantiated")

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("requested")
        if indexPath.row == 0 {
            performSegueWithIdentifier("hamburgerProfile", sender: self)
            print("to profile")
        } else if indexPath.row == 1 {
            performSegueWithIdentifier("hamburgerContainer", sender: self)
            print("to timeline")
        } else if indexPath.row == 3 {
            performSegueWithIdentifier("hamburgerAccount", sender: self)
            print("to timeline")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "hamburgerProfile" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let profilePageViewController = navigationController.topViewController as! ProfilePageViewController
            profilePageViewController.hamburger = true
            profilePageViewController.currUser = User.currentUser
            print("\(User.currentUser)")
        } else if segue.identifier == "hamburgerAccount" {
            let accountViewController = segue.destinationViewController as! AccountViewController
            accountViewController.currUser = User.currentUser
            print("\(User.currentUser)")
        }
    }
}

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var menuLabel: UILabel!
    
}