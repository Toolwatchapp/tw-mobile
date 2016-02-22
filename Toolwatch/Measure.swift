//
//  Measure.swift
//  Toolwatch
//
//  Created by math on 2016-02-22.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import Foundation

class Measure {
    
    var id: Int
    var measureUserTime: Double
    var measureReferenceTime: Double
    var accuracyUserTime: Double!
    var accuracyReferenceTime: Double!
    var accuracy: Double!
    
    init(id: Int, measureTime: Double, measureReferenceTime:Double,  accuracyTime: Double, accuracyReferenceTime: Double){
        self.id = id
        self.measureReferenceTime = measureReferenceTime
        self.measureUserTime = measureTime
        self.accuracyUserTime = accuracyTime
        self.accuracyReferenceTime = accuracyReferenceTime
    }
    
    init(measureTime: Double, measureReferenceTime:Double){
        self.id = -1
        self.measureReferenceTime = measureReferenceTime
        self.measureUserTime = measureTime
    }
    
    func addAccuracyMeasure(accuracyTime: Double, accuracyReferenceTime: Double){
        
        self.accuracyUserTime = accuracyTime
        self.accuracyReferenceTime = accuracyReferenceTime
        
        let userDelta = self.accuracyUserTime-self.measureUserTime
        let refDelta = self.accuracyReferenceTime-self.accuracyUserTime
        self.accuracy = round(10 * (userDelta*86400/refDelta)-86400) / 10
    }
    
    
    
}
