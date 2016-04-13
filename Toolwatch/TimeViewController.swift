//
//  TimeViewController.swift
//  Toolwatch
//
//  Created by math on 2016-04-12.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {
    
    
    @IBOutlet weak var hoursMinutesLabel: UILabel!
    @IBOutlet weak var AMLabel: UILabel!
    @IBOutlet weak var PMLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var UTCHoursMinutes: UILabel!
    @IBOutlet weak var leapYearLabel: UILabel!
    @IBOutlet weak var leapYearIndicator: UIView!
    @IBOutlet weak var secondsHand: UIImageView!
    @IBOutlet weak var hoursHand: UIImageView!
    @IBOutlet weak var minutesHand: UIImageView!
    @IBOutlet weak var moonPhases: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Time", image: UIImage(named: "clock-image"), tag: 1)
    }
    
    override func viewDidAppear(animated: Bool) {
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("setTime"), userInfo: nil, repeats: true)

        super.viewDidAppear(animated)
    }
    
    func setTime(){
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calendar?.components([.Hour, .Minute, .Second, .Nanosecond], fromDate: NSDate())
        var hour = components!.hour
        let minutes = components!.minute
        let seconds = components!.second
        let milliSeconds = components!.nanosecond / 1000000
        let tenthSeconds = components!.nanosecond / 1_000_000_00
        
        if(hour > 12){
            hour = hour - 12;
            PMLabel.enabled = true
            AMLabel.enabled = false
        }
        
        hoursMinutesLabel.text = ((hour<10) ? "0"+String(hour) : String(hour)) + ":"
            + ((minutes<10) ? "0"+String(minutes) : String(minutes));
        
        secondsLabel.text = ((seconds<10) ? "0"+String(seconds) : String(seconds)) + "." + String(tenthSeconds);
        
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        UTCHoursMinutes.text = dateFormatter.stringFromDate(date)
        
        //1.95  being the position of the hour hand at design time
        rotateImage(hoursHand, angle: Double((((Double(hour)-1.95)*M_PI/6.0)) + (Double(minutes)*M_PI/(6.0*60.0)) + (Double(seconds)*M_PI/(360.0*60.0) )))
        
        //47.5 being the position of the minute hand at design time
        rotateImage(minutesHand, angle: Double(((Double(minutes)-47.5)*M_PI/30.0) + (Double(seconds) * M_PI/(30.0*60.0) )))
        
        //36 being the position of the second hand at design time
        rotateImage(secondsHand, angle: Double((Double(seconds-36)+Double(milliSeconds)/1000.0))*M_PI/Double(30.0))
        
        rotateImage(moonPhases, angle: -moonPhasePercent()*0.279)
        
    }
    
    private func moonPhasePercent() -> Double{
        let synodic = 29.53058867
        let msPerDay = 86400000.0
        let baseStringDate = "08/04/2005 08:48:00 +0000"
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss ZZZ"
        let defaultTimeZoneStr = formatter.dateFromString(baseStringDate)
        
        let diff = NSDate().timeIntervalSince1970 - (defaultTimeZoneStr?.timeIntervalSince1970)!
        
        var phase = diff / (synodic * msPerDay)
        phase *= 100
        phase %= 100
        if ( phase < 0 ){
            
            phase += 100
        }
        
        return phase
    }
    
    private func rotateImage(hand:UIImageView, angle:Double){
        
        
        UIView.animateWithDuration(0.1, animations: {
            
            hand.transform = CGAffineTransformMakeRotation(CGFloat(angle))
        })

    }
}
