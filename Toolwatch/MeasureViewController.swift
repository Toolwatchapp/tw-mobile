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
    @IBOutlet weak var syncButton: UIButton!
    @IBOutlet weak var addMinuteButton: UIButton!
    @IBOutlet weak var removeMinuteButton: UIButton!
    var offsetedDate: NSDate!
    var clickedDate: NSDate!
    var watch:Watch!
    
    /**
     Override didLoad so we can create the header
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNextMinute()
        
        syncButton.layer.cornerRadius = 5;
        addMinuteButton.layer.cornerRadius = 5;
        removeMinuteButton.layer.cornerRadius = 5;
        
         // loop through notifications and cancel the one for the current watch
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications!{
            if (notification.userInfo!["UUID"] as! Int == self.watch.id) {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                break
            }
        }

        super.createHeader("header-measure", title: "Synchronization",
            subtitle: "\nPlease hit the button when \nthe seconds-hand reaches the time bellow",
            rightBtnArt: "refresh-btn", rightBtnAction: "refreshBtnClicked:", leftBtnArt: "back-btn", leftBtnAction: "backBtnClicked:", headerProportion:0.35)
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        //We used 35% of the frame for the header
        switch indexPath.item{
        case 0: // +/- button
            return self.view.frame.size.height * 0.075
        case 1: // Time label
            return self.view.frame.size.height * 0.4
        case 2: // I am sync button
            return self.view.frame.size.height * 0.2
        default: // Should'nt happen
            return 0
        }
    }
    
    /**
     Changes the time label's text
     */
    private func setTime(){

        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        time.text = formatter.stringFromDate(offsetedDate)+":00"
    }
    
    /**
     Computes the next minute given current time
     */
    private func getNextMinute(){
        
        let d = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.Second, fromDate: d)
        let seconds = components.second
        var offsetSeconds = 0;
        
        if(seconds >= 50){
            offsetSeconds = 60 - seconds
        }else{
            offsetSeconds = -seconds
        }
        
        offsetedDate = d.dateByAddingTimeInterval(Double(offsetSeconds+60))
        
        setTime()
    }
    
    /**
     Adds a minute to the text
     
     - parameter sender
     */
    @IBAction func retrieveMinute(sender: AnyObject) {
        
        offsetedDate = offsetedDate.dateByAddingTimeInterval(-60);
        setTime()
    }
    
    /**
     Removes a minute to the text
     
     - parameter sender
     */
    @IBAction func addMinute(sender: AnyObject) {
        offsetedDate = offsetedDate.dateByAddingTimeInterval(60);
        setTime()
    }
    
    @IBAction func syncButtonPressed(sender: AnyObject){
        clickedDate = NSDate();
        watch.addMeasure(clickedDate.timeIntervalSince1970, referenceTime: offsetedDate.timeIntervalSince1970)
        
        let notification = UILocalNotification()
        
        notification.alertAction = "open"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["UUID": watch.id, ]
        notification.category = "TODO_CATEGORY"
        
        //This was measure 2/2, display the result screen
        if(watch.currentStatus() == Watch.Status.ACCURACY_MEASURE){
            let resultView =  self.storyboard?.instantiateViewControllerWithIdentifier("ResultID") as! UINavigationController
            let resultTableView = resultView.topViewController as! ResultViewController
            resultTableView.watch = self.watch
            self.presentViewController(resultView, animated: true, completion: nil)
            
            notification.alertBody = "Let's start a new measure for your " + self.watch.brand + " " + self.watch.model + "!"
            notification.fireDate = NSDate().dateByAddingTimeInterval(30*24*60*60) // 1 month
            
        //This was measure 1/1 go back to the watch list
        }else{
            notification.alertBody = "It's to the check your " + self.watch.brand + " " + self.watch.model + " acuracy !"
            notification.fireDate = NSDate().dateByAddingTimeInterval(12*60*60) // 12 hours
            self.dismissViewControllerAnimated(true, completion: nil);
        }
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)


    }
    
    /**
     Refreshes the time
     
     - parameter sender
     */
    func refreshBtnClicked(sender:UIButton!){
        getNextMinute();
    }
    
    /**
     Handle click on the back button
     
     - parameter sender: The Back button
     */
    func backBtnClicked(sender:UIButton!){
        self.dismissViewControllerAnimated(true, completion: nil);
    }

}
