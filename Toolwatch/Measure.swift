//
//  Measure.swift
//  Toolwatch
//
//  Created by math on 2016-02-22.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import Foundation

/// Representes a couple of measure
class Measure : NSObject, NSCoding{
    
    var id: Int
    var measureUserTime: Double
    var measureReferenceTime: Double
    var accuracyUserTime: Double!
    var accuracyReferenceTime: Double!
    
    /**
     Default constructor for measure coming from the API
     
     - parameter id:
     - parameter measureTime:
     - parameter measureReferenceTime:
     - parameter accuracyTime:
     - parameter accuracyReferenceTime:
     
     - returns: new Measure
     */
    init(id: Int, measureTime: Double, measureReferenceTime:Double,  accuracyTime: Double, accuracyReferenceTime: Double){
        self.id = id
        self.measureReferenceTime = measureReferenceTime
        self.measureUserTime = measureTime
        self.accuracyUserTime = accuracyTime
        self.accuracyReferenceTime = accuracyReferenceTime
    }
    
    /**
     Creates a new measure
     
     - parameter measureTime:          1/2 userTime  in seconds since 1970
     - parameter measureReferenceTime: 1/2 refTime in seconds since 1970
     
     - returns: A new measure with timestamp as id
     */
    init(measureTime: Double, measureReferenceTime:Double){
        self.id = Int(NSDate().timeIntervalSince1970)
        self.measureReferenceTime = measureReferenceTime
        self.measureUserTime = measureTime
    }
    
    /**
     Creates a new measure
     
     - parameter measureTime:          1/2 userTime  in seconds since 1970
     - parameter measureReferenceTime: 1/2 refTime in seconds since 1970
     
     */
    init(id:Int, measureTime: Double, measureReferenceTime:Double){
        self.id = id
        self.measureReferenceTime = measureReferenceTime
        self.measureUserTime = measureTime
    }
    
    
    /**
     Adds the 2/2 measure
     
     - parameter accuracyTime:          accuracyUserTime in seconds since 1970
     - parameter accuracyReferenceTime: in seconds since 1970
     */
    func addAccuracyMeasure(accuracyTime: Double, accuracyReferenceTime: Double){
        
        self.accuracyUserTime = accuracyTime
        self.accuracyReferenceTime = accuracyReferenceTime
    }
    
    func accuracy() -> Double{
        let userDelta = self.accuracyUserTime-self.measureUserTime
        let refDelta = self.accuracyReferenceTime-self.measureReferenceTime
        return round(((userDelta*86400/refDelta)-86400)*100)/100
    }
    
    // MARK: NSCoding
    
    /**
    Encodes a measure for peristence
    
    - parameter aCoder:
    */
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeInteger(self.id, forKey: "MEASURE_ID");
        aCoder.encodeObject(self.measureUserTime, forKey: "MEASURE_USER_TIME")
        aCoder.encodeObject(self.measureReferenceTime, forKey: "MEASURE_REFERENCE_TIME")
        aCoder.encodeObject(self.accuracyUserTime, forKey: "MEASURE_ACCURACY_USER_TIME")
        aCoder.encodeObject(self.accuracyReferenceTime, forKey: "MEASURE_ACCURACY_REFERENCE_TIME")
        
    }
    
    /**
     Decodes a measure from persistence
     
     - parameter aDecoder:
     
     - returns: a populated measure
     */
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeIntegerForKey("MEASURE_ID")
        let measureUserTime = aDecoder.decodeObjectForKey("MEASURE_USER_TIME") as? Double
        let measureReferenceTime = aDecoder.decodeObjectForKey("MEASURE_REFERENCE_TIME") as? Double
        let accuracyUserTime = aDecoder.decodeObjectForKey("MEASURE_ACCURACY_USER_TIME") as? Double
        let accuracyReferenceTime = aDecoder.decodeObjectForKey("MEASURE_ACCURACY_REFERENCE_TIME") as? Double
        
        if(accuracyUserTime == nil && accuracyReferenceTime == nil){
            self.init(id: id, measureTime: measureUserTime!,measureReferenceTime: measureReferenceTime!)
        }else{
            self.init(id: id, measureTime: measureUserTime!, measureReferenceTime:measureReferenceTime!,  accuracyTime: accuracyUserTime!, accuracyReferenceTime: accuracyReferenceTime!)
        }
        
    }
    
}
