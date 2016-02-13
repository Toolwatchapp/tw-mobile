//
//  WatchCell.swift
//  Toolwatch
//
//  Created by math on 2016-02-12.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

class WatchCell: UITableViewCell {
    
    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var ctaButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    
    var watch: Watch! {
        didSet {
            watchLabel.text = watch.brand + " " + watch.model!
            accuracyLabel.text = self.accuracyLabelText(watch.statusId, accuracy: watch.accuracy)
            ctaButton = self.createCtaButton(watch.statusId)
            detailButton = self.createDetailButton()
        }
    }
    
    private func createDetailButton() -> UIButton {
        let image = UIImage(named: "right-icon") as UIImage?
        let button   = UIButton(type: UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(100, 100, 100, 100)
        button.setImage(image, forState: .Normal)
        button.addTarget(self, action: "btnTouched:", forControlEvents:.TouchUpInside)
        return button
    }
    
    private func accuracyLabelText(status:Float, accuracy:Float) -> String {
        
        var label = String()
        
        switch status {
            
        case 0, 1:
            label = "Pending measurement"
        case 1.5:
            label = "Measure in " + String(watch.accuracy) + " hours"
        case 2:
            label = String(watch.accuracy) + " seconds per day"
        default:
            label = "Something wrong"
        }
        return label
    }
    
    private func createCtaButton(status:Float) -> UIButton {
        
        var ctaButton   = UIButton(type: UIButtonType.System) as UIButton
        ctaButton.frame = CGRectMake(20, 20, 100, 50)
        ctaButton.backgroundColor = UIColor(colorLiteralRed: 77, green: 119, blue: 167, alpha: 0)
        ctaButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        ctaButton.layer.cornerRadius = 5;
        ctaButton.titleLabel!.font =  UIFont(name: "Avenir-Light", size: 15)
        ctaButton.titleLabel!.textColor = UIColor.whiteColor()
        
        switch status {
            
        case 0, 2:
            ctaButton.setTitle("Measure me", forState: UIControlState.Normal)
        case 1:
            ctaButton.setTitle("Check accuracy", forState: UIControlState.Normal)
        default:
            ctaButton = UIButton()
            ctaButton.frame = CGRectMake(0, 0, 0, 0)
            
        }
        
        return ctaButton
    }
    
    

}
