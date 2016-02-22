//
//  Measure.swift
//  Toolwatch
//
//  Created by math on 2016-02-22.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import Foundation

/// Representes a couple of measure
class Measure {
    
    var id: Int
    var measureUserTime: Double
    var measureReferenceTime: Double
    var accuracyUserTime: Double!
    var accuracyReferenceTime: Double!
    var accuracy: Double!
    
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
        self.computeAccuracy()
    }
    
    /**
     Creates a new measure
     
     - parameter measureTime:          1/2 userTime  in seconds since 1970
     - parameter measureReferenceTime: 1/2 refTime in seconds since 1970
     
     - returns: A new measure with -1 id
     */
    init(measureTime: Double, measureReferenceTime:Double){
        self.id = -1
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
        self.computeAccuracy()
        
    }
    
    /**
     Computes the accuracy to the 1/100 of sec
     */
    private func computeAccuracy(){
        
        let userDelta = self.accuracyUserTime-self.measureUserTime
        let refDelta = self.accuracyReferenceTime-self.measureReferenceTime
        self.accuracy = round(((userDelta*86400/refDelta)-86400)*100)/100

    }
    
    
    
}
