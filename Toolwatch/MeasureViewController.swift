//
//  MeasureViewController.swift
//  Toolwatch
//
//  Created by math on 2016-02-19.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

class MeasureViewController: UITableViewWithHeader {
    
    @IBOutlet weak var time: UILabel!
    var offset: Double = 1
    var initDate: NSDate = NSDate()
    var clickedDate: NSDate!
    
    /**
     Override didLaod so we can create the header
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        setTime()

        super.createHeader("header-measure", title: "Synchronization",
            subtitle: "\nPlease hit the button when \nthe seconds-hand reaches the time bellow",
            rightBtnArt: "refresh-btn", rightBtnAction: "refreshBtnClicked", leftBtnArt: "back-btn", leftBtnAction: "backBtnClicked:")
    }
    
    private func setTime(){
        let date = initDate.dateByAddingTimeInterval(offset*60.0)
        

        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        time.text = formatter.stringFromDate(date)+":00"
    }
    
    @IBAction func retrieveMinute(sender: AnyObject) {
        
        offset--
        setTime()
    }
    
    @IBAction func addMinute(sender: AnyObject) {
        offset++
        setTime()
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
            //watch = Watch(brand: brand.text!, model: model.text!, yearOfPurchase: yearOfPurchase.text!, serial: serial.text!, caliber: caliber.text!)
        }
    }
    
    

}
