//
//  Watch.swift
//  Toolwatch
//
//  Created by math on 2016-02-10.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import Foundation

/**
*  A simple datastructure for watches
*/
class Watch {
    
    var id: Int
    var brand: String
    var model: String
    var yearOfPurchase: String
    var serial: String
    var caliber: String
    var status: Watch.Status
    var measures: [Measure]
    
    /**
     Constructor for watches created in the app
     
     - parameter brand:
     - parameter model:
     - parameter yearOfPurchase:
     - parameter serial:
     - parameter caliber:
     
     - returns: A new watch with a -1 id and no measure
     */
    init(brand: String, model: String, yearOfPurchase: String, serial: String,
        caliber: String){
            
            self.brand = brand
            self.model = model
            self.yearOfPurchase = yearOfPurchase
            self.serial = serial
            self.caliber = caliber
            self.status = Status.NEVER_MEASURED
            self.id = -1
            self.measures = [Measure]()
    }
    
    /**
     Constructors for watches coming from the API
     
     - parameter id:
     - parameter brand:
     - parameter model:
     - parameter yearOfPurchase:
     - parameter serial:
     - parameter caliber:
     - parameter statusId:
     - parameter measures:
     
     - returns: A new watch
     */
    init(id: Int, brand: String, model: String, yearOfPurchase: String, serial: String,
        caliber: String, status: Watch.Status, measures: [Measure]){
        
            self.id = id
            self.brand = brand
            self.model = model
            self.yearOfPurchase = yearOfPurchase
            self.serial = serial
            self.caliber = caliber
            self.status = status
            self.measures = measures
    }
    
    /**
     Adds a measure to the watch
     
     - parameter userTime:      userTime in seconds since 1970
     - parameter referenceTime: referenceTime in seconds since 1970
     */
    func addMeasure(userTime:Double, referenceTime:Double){
        switch self.status {
            
        case Status.NEVER_MEASURED, Status.ACCURACY_MEASURE:
            measures.append(Measure(measureTime: userTime, measureReferenceTime: referenceTime))
            self.status = Status.WAITING_LIMIT
            break
        case Status.FIRST_MEASURE:
            measures.last!.addAccuracyMeasure(userTime, accuracyReferenceTime: referenceTime)
            self.status = Status.ACCURACY_MEASURE
            break
        default:
            print("Something went wrong")
        }
    }

    /**
     Gets the accuracy of the last measure
     
     - returns: the accuracy or an empty Double if we don't have any accuracy
     */
    func accuracy() -> Double{
        
        if(status == Status.ACCURACY_MEASURE){
            return measures.last!.accuracy;
        }
        return Double()
    }

    /**
     Gets the current status of a watch
     
     - returns: Watch.Status enum
     */
    func currentStatus() -> Watch.Status{
        
        if(self.status == Status.FIRST_MEASURE &&
            (NSDate().timeIntervalSince1970-measures.last!.measureReferenceTime)/3600 > 12){
                
            self.status = Status.FIRST_MEASURE
        }
        
        return self.status
    }

    /**
     Computes the time remaining before we can take the second measure
     
     - returns: hours left
     */
    func timeToWaitBeforeAccuracy() -> Int{
        return Int(round(12-(NSDate().timeIntervalSince1970-measures.last!.measureReferenceTime)/3600))
    }
    
    /**
     
     - NEVER_MEASURED:   The watch has just been created
     - FIRST_MEASURE:    We are at 1/2 state
     - WAITING_LIMIT:    We did the first measure less than 12 hours ago
     - ACCURACY_MEASURE: We are at the 2/2 state
     */
    enum Status {
        case NEVER_MEASURED
        case FIRST_MEASURE
        case WAITING_LIMIT
        case ACCURACY_MEASURE
    }
    
}
