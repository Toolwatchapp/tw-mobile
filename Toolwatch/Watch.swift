//
//  Watch.swift
//  Toolwatch
//
//  Created by math on 2016-02-10.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

/**
*  A simple datastructure for watches
*/
struct Watch {
    
    var id: Int
    var brand: String
    var model: String
    var yearOfPurchase: String
    var serial: String
    var caliber: String
    var statusId: Float
    var accuracy: Float
    
    /**
     Constructor for watches created in the app
     
     - parameter brand:
     - parameter model:
     - parameter yearOfPurchase:
     - parameter serial:
     - parameter caliber:
     
     - returns: A new watch with a -1 id
     */
    init(brand: String, model: String, yearOfPurchase: String, serial: String,
        caliber: String){
            
            self.brand = brand
            self.model = model
            self.yearOfPurchase = yearOfPurchase
            self.serial = serial
            self.caliber = caliber
            self.statusId = 0
            self.id = -1
            self.accuracy = 0.0
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
     - parameter accuracy:
     
     - returns: A new watch
     */
    init(id: Int, brand: String, model: String, yearOfPurchase: String, serial: String,
        caliber: String, statusId: Float, accuracy: Float){
        
            self.id = id
            self.brand = brand
            self.model = model
            self.yearOfPurchase = yearOfPurchase
            self.serial = serial
            self.caliber = caliber
            self.statusId = statusId
            self.accuracy = accuracy
    }
    
}
