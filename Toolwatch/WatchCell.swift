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
    
    var watch: Watch! {
        didSet {
            watchLabel.text = watch.brand + " " + watch.model!
            accuracyLabel.text = self.accuracyLabelText(watch.statusId, accuracy: watch.accuracy)
            self.createCtaButton(watch.statusId)
            self.createDetailButton()
        }
    }
    
    private func createDetailButton() {
        let image = UIImage(named: "right-icon") as UIImage?
        let button   = UIButton(type: UIButtonType.Custom) as UIButton
        button.frame = CGRectMake((self.frame.width - 50), 25, 30, 30)
        button.setImage(image, forState: .Normal)
        
        
        self.addSubview(button);
        
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
    
    func test(){
        print("there")
        print(self.watch.id)
    }
    
    private func createCtaButton(status:Float) {
        
        var ctaButton   = UIButton(type: UIButtonType.System) as UIButton
        
        ctaButton.frame = CGRectMake((self.frame.width - 180), 25, 120, 30)
        ctaButton.backgroundColor = UIColor(red: 77/255, green: 119/255, blue: 167/255, alpha: 1)
        ctaButton.addTarget(self, action: "test", forControlEvents: UIControlEvents.TouchUpInside)
        ctaButton.layer.cornerRadius = 5;
        ctaButton.titleLabel?.textAlignment = NSTextAlignment.Center
        ctaButton.titleLabel!.font =  UIFont(name: "Avenir-Light", size: 15)
        ctaButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        switch status {
            
        case 0, 2:
            ctaButton.setTitle("Measure me", forState: UIControlState.Normal)
        case 1:
            ctaButton.setTitle("Check accuracy", forState: UIControlState.Normal)
        default:
            ctaButton = UIButton()
            ctaButton.frame = CGRectMake(0, 0, 0, 0)
            
        }
        
        self.addSubview(ctaButton);
    }
    
    

}
