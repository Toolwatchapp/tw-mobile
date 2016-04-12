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
     var accuracy:Float=Float.infinity
     var age:Float=0
     var status:Float = Watch.Status.FIRST_MEASURE
    
    /**
     Default constructor for measure coming from the API
     
     - parameter id:                    <#id description#>
     - parameter measureUserTime:       <#measureUserTime description#>
     - parameter measureReferenceTime:  <#measureReferenceTime description#>
     - parameter accuracyTime:          <#accuracyTime description#>
     - parameter accuracyReferenceTime: <#accuracyReferenceTime description#>
     - parameter accuracy:              <#accuracy description#>
     - parameter accuracyAge:           <#accuracyAge description#>
     - parameter status:                <#status description#>
     
     - returns: <#return value description#>
     */
    init(id: Int, measureUserTime: Double, measureReferenceTime: Double, accuracyTime: Double, accuracyReferenceTime: Double,
        accuracy: Float, accuracyAge: Float, status: Float){
            self.id = id
            self.measureUserTime = measureUserTime
            self.measureReferenceTime = measureReferenceTime
            self.accuracy = accuracy
            self.age = accuracyAge
            self.status = status
    }
    
    /**
     Creates a new measure
     
     - parameter measureTime:          1/2 userTime  in seconds since 1970
     - parameter measureReferenceTime: 1/2 refTime in seconds since 1970
     
     - returns: A new measure with timestamp as id
     */
    init(measureTime: Double, measureReferenceTime:Double){
        self.id = -Int(NSDate().timeIntervalSince1970)
        self.measureReferenceTime = measureReferenceTime
        self.measureUserTime = measureTime
    }
    
    /**
     Creates a new measure
     
     - parameter measureTime:          1/2 userTime  in seconds since 1970
     - parameter measureReferenceTime: 1/2 refTime in seconds since 1970
     
     - returns: A new measure
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
        self.status = Watch.Status.ACCURACY_MEASURE
        let userDelta = self.accuracyUserTime-self.measureUserTime
        let refDelta = self.accuracyReferenceTime-self.measureReferenceTime
        self.accuracy = Float(round(((refDelta*86400/userDelta)-86400)*100)/100.0)
    }
    
    /**
     Returns measure accuracy
     
     - returns: Float
     */
    func getAccuracy() -> Float{
        
        return self.accuracy;
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
        aCoder.encodeFloat(self.age, forKey: "MEASURE_AGE")
        aCoder.encodeFloat(self.accuracy, forKey: "MEASURE_ACCURACY")
        aCoder.encodeFloat(self.status, forKey: "MEASURE_STATUS")
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
        let age = aDecoder.decodeFloatForKey("MEASURE_AGE")
        let accuracy = aDecoder.decodeFloatForKey("MEASURE_ACCURACY")
        let status = aDecoder.decodeFloatForKey("MEASURE_STATUS")

        self.init(id: id, measureUserTime: measureUserTime!, measureReferenceTime:measureReferenceTime!,
            accuracyTime: accuracyUserTime!, accuracyReferenceTime: accuracyReferenceTime!,
            accuracy:accuracy, accuracyAge:age, status:status)
        
    }
    
}
