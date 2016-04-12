//
//  WatchCell.swift
//  Toolwatch
//
//  Created by math on 2016-02-12.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

/// Custom UITableViewCell for the dashboard
class WatchCell: UITableViewCell {
    
    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    
    /// Constructor for the custom cell
    var watch: Watch! {
        didSet {
            watchLabel.text = watch.brand
            modelLabel.text = watch.model
            accuracyLabel.text = self.accuracyLabelText()
            self.createCtaButton()
            self.createDetailButton()
        }
    }
    
    /// CallBack for buttons in the cell
    /// http://stackoverflow.com/a/31400551
    var detailCallback : ((watchCell: WatchCell)-> Void)?
    var measureCallback : ((watchCell: WatchCell)-> Void)?
    
    var indexPath:NSIndexPath!
    
    /**
     Create the detail button showing the watch data
     */
    private func createDetailButton() {
        let image = UIImage(named: "right-icon") as UIImage?
        let button   = UIButton(type: UIButtonType.Custom) as UIButton
        button.frame = CGRectMake((self.frame.width - 50), 40, 30, 30)
        button.setImage(image, forState: .Normal)
        button.addTarget(self, action: "detailBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(button);
        
    }
    
    /**
     Creates the accuracy label based on the status and the accuracy
     
     - parameter status:   Status of the watch
     - parameter accuracy: Accuracy of the watch
     
     - returns: A String for the accuracy label
     */
    private func accuracyLabelText() -> String {
        
        var label = String()
        
        switch watch.getStatus() {
            
        case Watch.Status.NEVER_MEASURED, Watch.Status.FIRST_MEASURE:
            label = "Pending measurement"
            break
        case Watch.Status.WAITING_LIMIT:
            label = "Measure accuracy in " + String(watch.timeToWaitBeforeAccuracy()) + " hours"
            break
        case Watch.Status.ACCURACY_MEASURE:
            label = String(watch.accuracy()) + " seconds per day"
            break
        default:
            print("Something went wrong")
        }
        return label
    }
    
    /**
     action for detail button
     */
    func detailBtnClicked(){
        detailCallback!(watchCell: self);
    }
    
    /**
     action for measure button
     */
    func measureBtnClicked(){
        measureCallback!(watchCell: self);
    }
    
    /**
     creates the CTA button (measure-me / check accuracy)
     
     - parameter status: the status of the watch
     */
    private func createCtaButton() {
        
        let ctaButton   = UIButton(type: UIButtonType.System) as UIButton
        
        ctaButton.frame = CGRectMake((self.frame.width - 180), 40, 120, 30)
        ctaButton.backgroundColor = UIColor(red: 77/255, green: 119/255, blue: 167/255, alpha: 1)
        ctaButton.addTarget(self, action: "measureBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        ctaButton.layer.cornerRadius = 5;
        ctaButton.titleLabel?.textAlignment = NSTextAlignment.Center
        ctaButton.titleLabel!.font =  UIFont(name: "Avenir-Light", size: 15)
        ctaButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        switch watch.getStatus() {
            
        case Watch.Status.NEVER_MEASURED, Watch.Status.ACCURACY_MEASURE:
            ctaButton.setTitle("Measure me", forState: UIControlState.Normal)
            self.addSubview(ctaButton);
            break
        case Watch.Status.FIRST_MEASURE:
            ctaButton.setTitle("Check accuracy", forState: UIControlState.Normal)
            self.addSubview(ctaButton);
            break
        case Watch.Status.WAITING_LIMIT:
            print("Waiting")
            break
        default:
            print("Something went wrong")
        }
    }

}
