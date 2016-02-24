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

        super.createHeader("header-measure", title: "Synchronization",
            subtitle: "\nPlease hit the button when \nthe seconds-hand reaches the time bellow",
            rightBtnArt: "refresh-btn", rightBtnAction: "refreshBtnClicked:", leftBtnArt: "back-btn", leftBtnAction: "backBtnClicked:")
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
        
        if(watch.currentStatus() == Watch.Status.ACCURACY_MEASURE){
            let resultView =  self.storyboard?.instantiateViewControllerWithIdentifier("ResultID") as! UINavigationController
            let resultTableView = resultView.topViewController as! ResultViewController
            resultTableView.watch = self.watch
            self.presentViewController(resultView, animated: true, completion: nil)
        }else{
            self.dismissViewControllerAnimated(true, completion: nil);
        }

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
