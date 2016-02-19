//
//  AddWatchViewController.swift
//  Toolwatch
//
//  Created by math on 2016-02-19.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

/// Controller for the add watch view
class AddWatchViewController: UITableViewWithHeader {
    
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var caliber: UITextField!
    @IBOutlet weak var yearOfPurchase: UITextField!
    @IBOutlet weak var serial: UITextField!
    var watch: Watch!
    
    /**
     Override didLaod so we can create the header
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.createHeader("header-watch", title: "", subtitle: "Add a watch",
            btnArt: "back-btn", btnAction: "backBtnClicked:", rightButton: false)
    }
    
    /**
     Handle click on the back button
     
     - parameter sender: The Back button
     */
    func backBtnClicked(sender:UIButton!){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    /**
     When we are about to leave, create a new watch with the form content
     
     - parameter segue
     - parameter sender
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveWatch" {
            watch = Watch(brand: brand.text!, model: model.text!, yearOfPurchase: yearOfPurchase.text!, serial: serial.text!, caliber: caliber.text!)
        }
    }

}
