//
//  WatchesViewController.swift
//  Toolwatch
//
//  Created by math on 2016-02-10.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

class WatchesViewController: UITableViewWithHeader {
    
    var watches:[Watch] = watchesData

    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.createHeader("header-art-image", title: "Measures", subtitle: "Add or start a measure")
       
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return watches.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WatchCell", forIndexPath: indexPath)
            as! WatchCell
        
        let watch = watches[indexPath.row] as Watch
        cell.watch = watch
        return cell
    }

}
