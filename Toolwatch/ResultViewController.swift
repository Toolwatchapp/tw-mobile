//
//  ResultViewController.swift
//  Toolwatch
//
//  Created by math on 2016-02-23.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

class ResultViewController: UITableViewWithHeader {
    
    @IBOutlet weak var measureButton: UIButton!
    var watch:Watch!
   
    /**
     Add the header and related fields
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        measureButton.layer.cornerRadius = 5;
        
        super.createHeader(
            "header-result",
            headerProportion: Float(0.6)
        )
        
        self.tableView.tableHeaderView?.addSubview(
            self.createLabel(
                "CONGRATULATION",
                postion: ((self.tableView.tableHeaderView?.frame.size.height)!/2)-20,
                font: "Avenir-Light",
                size: 12
            )
        )
        
        self.tableView.tableHeaderView?.addSubview(
            self.createLabel(
                "THE ACCURACY OF YOUR " + self.watch.brand.uppercaseString + " " + self.watch.model.uppercaseString + " IS:",
                postion: ((self.tableView.tableHeaderView?.frame.size.height)!/2),
                font: "Avenir-Light",
                size: 12
            )
        )
        
        self.tableView.tableHeaderView?.addSubview(
            self.createLabel(
                String(self.watch.accuracy()),
                postion: ((self.tableView.tableHeaderView?.frame.size.height)!/2)+60,
                font: "Avenir-Light",
                size: 50
            )
        )
        
        self.tableView.tableHeaderView?.addSubview(
            self.createLabel(
                "SECONDS PER DAY",
                postion: ((self.tableView.tableHeaderView?.frame.size.height)!/2)+110,
                font: "Avenir-Light",
                size: 12
            )
        )
    }
    
    /**
     Defines custom height for each rows
     
     - parameter tableView:
     - parameter indexPath:
     
     - returns: the heigh of a row
     */
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        //We used 60% of the frame for the header
        switch indexPath.item{
        case 0: // start a new measure button
            return self.view.frame.size.height * 0.1
        case 1: // or be a true watch lover
            return self.view.frame.size.height * 0.15
        case 2: // share icons
            return self.view.frame.size.height * 0.1
        default: // Should'nt happen
            return 0
        }
    }
    
}
