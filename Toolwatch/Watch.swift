//
//  Watch.swift
//  Toolwatch
//
//  Created by math on 2016-02-10.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import Foundation

/**
*  A simple datastructure for watches that handles saving via NSCoding
*/
class Watch: NSObject, NSCoding {
    
    /// Core attributes
    var id: Int
    var brand: String
    var model: String
    var yearOfPurchase: String
    var serial: String
    var caliber: String
    var status: Int
    var measures: [Measure]
    
    /// Persistence related attribute
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("watches")
    
    
    /**
     Constructor for watches created in the app
     
     - parameter brand:
     - parameter model:
     - parameter yearOfPurchase:
     - parameter serial:
     - parameter caliber:
     
     - returns: A new watch with timestamp as id
     */
    init(brand: String, model: String, yearOfPurchase: String, serial: String,
        caliber: String){
            
            self.brand = brand
            self.model = model
            self.yearOfPurchase = yearOfPurchase
            self.serial = serial
            self.caliber = caliber
            self.status = Status.NEVER_MEASURED
            self.id = Int(NSDate().timeIntervalSince1970)
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
        caliber: String, status: Int, measures: [Measure]){
        
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
            return measures.last!.accuracy();
        }
        return Double()
    }

    /**
     Gets the current status of a watch
     
     - returns: Watch.Status enum
     */
    func currentStatus() -> Int{
        
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
        print(measures.last!.measureReferenceTime)
        return Int(round(12-(NSDate().timeIntervalSince1970-measures.last!.measureReferenceTime)/3600))
    }
    
    /**
     
     - NEVER_MEASURED:   The watch has just been created
     - FIRST_MEASURE:    We are at 1/2 state
     - WAITING_LIMIT:    We did the first measure less than 12 hours ago
     - ACCURACY_MEASURE: We are at the 2/2 state
     */
    struct Status {
        static let NEVER_MEASURED:Int = 0
        static let FIRST_MEASURE:Int = 1
        static let WAITING_LIMIT:Int = 2
        static let ACCURACY_MEASURE:Int = 3
    }
    
    // MARK: NSCoding
    
    /**
    Encodes a watch and save it to file
    
    - parameter aCoder:
    */
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeInteger(self.id, forKey: "WATCH_ID");
        aCoder.encodeObject(self.brand, forKey: "WATCH_BRAND")
        aCoder.encodeObject(self.model, forKey: "WATCH_MODEL")
        aCoder.encodeObject(self.yearOfPurchase, forKey: "WATCH_YEAR")
        aCoder.encodeObject(self.serial, forKey: "WATCH_SERIAL")
        aCoder.encodeObject(self.caliber, forKey: "WATCH_CALIBER")
        aCoder.encodeInteger(self.status, forKey: "WATCH_STATUS")
        aCoder.encodeObject(self.measures, forKey: "WATCH_MEASURES")
        
    }
    
    /**
     Decodes a watch from file
     
     - parameter aDecoder: 
     
     - returns: a populated watch
     */
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeIntegerForKey("WATCH_ID")
        let brand = aDecoder.decodeObjectForKey("WATCH_BRAND") as! String
        let model = aDecoder.decodeObjectForKey("WATCH_MODEL") as! String
        let year = aDecoder.decodeObjectForKey("WATCH_YEAR") as! String
        let serial = aDecoder.decodeObjectForKey("WATCH_SERIAL") as! String
        let caliber = aDecoder.decodeObjectForKey("WATCH_CALIBER") as! String
        let measures = aDecoder.decodeObjectForKey("WATCH_MEASURES") as! [Measure]
        let status = aDecoder.decodeIntegerForKey( "WATCH_STATUS" )
        
        self.init(id: id, brand: brand, model: model, yearOfPurchase: year, serial: serial,
            caliber: caliber, status: status, measures: measures)
    }

    
}
