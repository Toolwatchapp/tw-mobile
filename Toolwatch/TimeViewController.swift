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
    @IBOutlet weak var secondsHand: UIImageView!
    @IBOutlet weak var hoursHand: UIImageView!
    @IBOutlet weak var minutesHand: UIImageView!
    @IBOutlet weak var moonPhases: UIImageView!
    @IBOutlet weak var leftMoonMonth: UILabel!
    @IBOutlet weak var rightMoonMonth: UILabel!
    @IBOutlet weak var leftMoonDay: UILabel!
    @IBOutlet weak var rightMoonDay: UILabel!
    @IBOutlet weak var inClockMonth: UILabel!
    @IBOutlet weak var inClockDay: UILabel!
    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    
    @IBOutlet weak var isThreeYearLeapYear: UILabel!
    @IBOutlet weak var isTwoYearLeapYearLabel: UILabel!
    @IBOutlet weak var isLeapYearLabel: UILabel!
    @IBOutlet weak var isOneYearLeapYear: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Time", image: UIImage(named: "clock-image"), tag: 1)
    }
    
    override func viewDidAppear(animated: Bool) {
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("setTime"), userInfo: nil, repeats: true)

        super.viewDidAppear(animated)
        
        setSlowMovingParts();
    }
    
    /**
     Initialisizes components moving less once per day
     */
    func setSlowMovingParts(){
        setMoon(leftMoonMonth, day: leftMoonDay, date: findPhase(-60*60*24, targetPhase: 0))
        setMoon(rightMoonMonth, day: rightMoonDay, date: findPhase(60*60*24, targetPhase: 15))
        setInClockTime();
    }
    
    /**
     Hilights the right leap year indicator given the current year
     
     - parameter year: <#year description#>
     */
    func setLeapYear(year:Int){
        
        var movingYear = year
        let labels:[UILabel] = [isLeapYearLabel, isOneYearLeapYear, isTwoYearLeapYearLabel, isThreeYearLeapYear]
        
        while(!isLeapYear(movingYear)){
            movingYear++
        }
        
        leapYearLabel.text = String(movingYear)
        labels[movingYear-year].textColor = UIColor.blackColor()
    }
    
    /**
     Determines is a year is leap or not
     
     - parameter year: <#year description#>
     
     - returns: <#return value description#>
     */
    func isLeapYear(year:Int) -> Bool{
        if ((year % 4 == 0) && (year % 100 != 0))
            || (year % 400 == 0){
                return true
        }
        return false
    }
    
    /**
     Sets the inclock times
     */
    func setInClockTime(){
        let components = calendar?.components([.Weekday, .Day, .Month, .Year], fromDate: NSDate())
        let monthNumber = components?.month
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        let months = dateFormatter.shortMonthSymbols
        let weekDayNumber = components?.weekday
        let dayNumber = components?.day
        let days = dateFormatter.shortWeekdaySymbols
        inClockMonth.text = months[monthNumber!-1].uppercaseString
        inClockDay.text = days[weekDayNumber!-1].uppercaseString + " " + String(dayNumber!)
        setLeapYear((components?.year)!)
    }
    
    /**
     Set month and day below a given moon and date
     
     - parameter month: <#month description#>
     - parameter day:   <#day description#>
     - parameter date:  <#date description#>
     */
    func setMoon(month:UILabel, day:UILabel, date:NSDate){
        
        let components = calendar?.components([.Day, .Month], fromDate: date)
        let monthNumber = components?.month
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        let months = dateFormatter.shortMonthSymbols
        let dayNumber = components?.day
        month.text = months[monthNumber!-1].uppercaseString
        day.text = String(dayNumber!)
    }
    
    /**
     Move all moving parts (hands, seconds, and so on)
     */
    func setTime(){
        
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
        rotateView(hoursHand, angle: Double((((Double(hour)-1.95)*M_PI/6.0)) + (Double(minutes)*M_PI/(6.0*60.0)) + (Double(seconds)*M_PI/(360.0*60.0) )))
        
        //47.5 being the position of the minute hand at design time
        rotateView(minutesHand, angle: Double(((Double(minutes)-47.5)*M_PI/30.0) + (Double(seconds) * M_PI/(30.0*60.0) )))
        
        //36 being the position of the second hand at design time
        rotateView(secondsHand, angle: Double((Double(seconds-36)+Double(milliSeconds)/1000.0))*M_PI/Double(30.0))
        
        rotateView(moonPhases, angle: -moonPhasePercent()*0.279)
        
    }
    
    /**
     Finds at which date a given moon phase [0-29] will occur. 
     Seeks the calendar by jumpingTime jumps
     
     - parameter jumpingTime: <#jumpingTime description#>
     - parameter targetPhase: <#targetPhase description#>
     
     - returns: <#return value description#>
     */
    private func findPhase(jumpingTime:Double, targetPhase:Double)->NSDate{
        
        var date = NSDate().dateByAddingTimeInterval(-jumpingTime)
        var year = 0.0
        var day = 0.0
        var month = 0.0
        
        repeat{
            
            date = date.dateByAddingTimeInterval(jumpingTime)
            
            let components = calendar?.components([.Day, .Year, .Month], fromDate: date)
            day = Double(components!.day)
            month = Double(components!.month)
            year = Double(components!.year)
            
            
        }while(conwayMoonPhase(year, month: month, day: day) != targetPhase)
        
        return date;
    }
    
    /**
     http://www.ben-daglish.net/moon.shtml
     
     Returns 0 to 29 (0 = full moon, 15 = new moon)
     
     - parameter year:  <#year description#>
     - parameter month: <#month description#>
     - parameter day:   <#day description#>
     */
    private func conwayMoonPhase(year:Double, month:Double, day:Double)->Double
    {
        var r:Double = year % 100;
        r %= 19;
        if (r>9){ r -= 19;}
        r = ((r * 11.0) % 30) + month + day;
        if (month<3){r += 2;}
        r -= ((year<2000) ? 4 : 8.3)
        r = floor(r+0.5)%30;
        return (r < 0) ? r+30 : r;
    }
    
    /**
     Computes the percentage of the moon orbits
     
     - returns: <#return value description#>
     */
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
    
    /**
     Utility function to rotate image to a given angle
     
     - parameter hand:  <#hand description#>
     - parameter angle: <#angle description#>
     */
    private func rotateView(view:UIView, angle:Double, anchor:CGPoint = CGPointMake(0.5, 0.5)){
        
        view.layer.anchorPoint = anchor
        UIView.animateWithDuration(0.1, animations: {
            
            view.transform = CGAffineTransformMakeRotation(CGFloat(angle))
        })

    }
}
