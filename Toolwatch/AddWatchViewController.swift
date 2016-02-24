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
    @IBOutlet weak var addWatchButton: UIButton!
    var watch: Watch!
    
    /**
     Override didLaod so we can create the header
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addWatchButton.layer.cornerRadius = 5;
        
        super.createHeader("header-watch", title: "", subtitle: "Add a watch",
            btnArt: "back-btn", btnAction: "backBtnClicked:", rightButton: false)
    }
    
    /**
     Defines custom height for each rows
     
     - parameter tableView:
     - parameter indexPath:
     
     - returns: the heigh of a row
     */
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        //We used 30% of the frame for the header
        //We need 10% for the validate button
        //The 60% remaining are 40% for inputs and 20% for labels
        
        //Even number are labels
        if(indexPath.item % 2 == 0 && indexPath.item != 10){
            //The heigh of the screen * (20% / 5 labels / 100)
            return self.view.frame.size.height * (20/5/100)
       
        //Odd numbers are input
        }else if(indexPath.item != 10){
            //The heigh of the screen * (40% / 5 inputs / 100)
            return self.view.frame.size.height * (40/5/100)
            
        //The validate button
        }else{
            return self.view.frame.size.height * 0.1
        }
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
