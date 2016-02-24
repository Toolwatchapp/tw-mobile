//
//  EditWatchViewController.swift
//  Toolwatch
//
//  Created by math on 2016-02-24.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

class EditWatchViewController: UITableViewWithHeader {
    
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var caliber: UITextField!
    @IBOutlet weak var yearOfPurchase: UITextField!
    @IBOutlet weak var serial: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var EditButton: UIButton!
    var watch: Watch!
    
    /**
     Override didLaod so we can create the header
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brand.text = watch.brand
        model.text = watch.model
        caliber.text = watch.caliber
        yearOfPurchase.text = watch.yearOfPurchase
        serial.text = watch.serial
        
        deleteButton.layer.cornerRadius = 5;
        EditButton.layer.cornerRadius = 5;
        
        super.createHeader("header-watch", title: "", subtitle: "Edit your " + watch.brand,
            btnArt: "back-btn", btnAction: "backBtnClicked:", rightButton: false)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        //We used 30% of the frame for the header
        //We need 10% for the validate button
        //The 60% remaining are 40% for inputs and 20 for labels
        
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
        if segue.identifier == "EditWatch" {
            
            watch.brand = brand.text!
            watch.model = model.text!
            watch.caliber = caliber.text!
            watch.yearOfPurchase = yearOfPurchase.text!
            watch.serial = serial.text!
            
        }else if segue.identifier == "DeleteWatch"{
            
            // loop through notifications and cancel the one for the soon to be deleted watch
            for notification in UIApplication.sharedApplication().scheduledLocalNotifications!{
                if (notification.userInfo!["UUID"] as! Int == self.watch.id) {
                    UIApplication.sharedApplication().cancelLocalNotification(notification)
                    break
                }
            }
            watch = nil
            
        }
        
    }

}
