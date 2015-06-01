//
//  SideMenuViewController.swift
//  Twitter
//
//  Created by Jon Choi on 5/30/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
//, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dummyView: UIView!

    @IBOutlet weak var tableView: UITableView!
    
    let menuArray = ["Profile", "Timeline", "Mentions", "Accounts"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.reloadData()
        println("i mean... it is loading")
    }
    
    override func viewDidAppear(animated: Bool) {
        println("it did appear....!")
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
//        cell.menuLabel.text = menuArray[indexPath.row]
//        println("cell \(indexPath.row) instantiated")
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    }
//    
}

//class MenuCell: UITableViewCell {
//    
//    @IBOutlet weak var menuLabel: UILabel!
//    
//}